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
(defun new-camera-video-capture (index)
  (%new-camera-video-capture index))

@export
(defun delete-camera-video-capture (capture)
  (%delete-camera-video-capture capture))

@export
(defun open-camera-video-capture (capture)
  (%open-camera-video-capture capture))

@export
(defun video-capture-is-opened? (capture)
  (%video-capture-is-opened? capture))

@export
(defun read-video-capture-image (capture image)
  (%read-video-capture-image capture (cvo-ptr image)))

@export
(defun grab-video-capture-image (capture)
  (%grab-video-capture-image capture))

@export
(defun retrieve-video-capture-image (capture image)
  (%retrieve-video-capture-image capture (cvo-ptr image)))
