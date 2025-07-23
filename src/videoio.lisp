(defpackage opencv-jit/videoio
  (:use #:cl
        #:cl-annot
        #:cl-annot.class
        #:opencv-jit/foreign
        #:opencv-jit/util
        #:opencv-jit/core))

(in-package :opencv-jit/videoio)

(cl-annot:enable-annot-syntax)

@export
(defclass camera-video-capture (cvo)
  ((index :accessor camera-index
          :initarg :index
          :initform 0
          :type integer
          :documentation "Index of the camera to capture the video from.")
   (image :accessor video-capture-image
          :initform (make-mat)
          :documentation "Images are read into existing matrix objects to save memory allocations.")))

@export
(defmethod initialize-instance :after ((a-capture camera-video-capture) &key)
  (unless (cvo-free-func a-capture)
    (let ((a-pointer (cvo-ptr a-capture)))
      (trivial-garbage:finalize a-capture
                                (lambda ()
                                  (%delete-camera-video-capture a-pointer))))))

@export
(defun make-camera-video-capture (an-index)
  (make-instance 'camera-video-capture :ptr (%new-camera-video-capture an-index)
                                       :index an-index))

@export
(defmethod open-camera-video-capture ((a-capture camera-video-capture))
  (%open-camera-video-capture (cvo-ptr a-capture) (camera-index a-capture)))

@export
(defmethod video-capture-is-opened? ((a-capture camera-video-capture))
  (%video-capture-is-opened? (cvo-ptr a-capture)))

@export
(defmethod read-image ((a-capture camera-video-capture))
  (let ((an-image (video-capture-image a-capture)))
    (%read-video-capture-image (cvo-ptr a-capture) (cvo-ptr (video-capture-image a-capture)))
    an-image))

@export
(defmethod grab-image ((a-capture camera-video-capture))
  (%grab-video-capture-image (cvo-ptr a-capture)))

@export
(defmethod retrieve-image ((a-capture camera-video-capture))
  (let ((an-image (video-capture-image a-capture)))
    (%retrieve-video-capture-image (cvo-ptr a-capture) (cvo-ptr (video-capture-image a-capture)))
    an-image))
