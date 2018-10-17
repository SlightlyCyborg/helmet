
(defpackage :helmet
  (:use :cl :sb-bsd-sockets))

(in-package :helmet)


(defun udp ()
  (make-instance
   'inet-socket :type :datagram :protocol :udp))

(defvar *socket* (udp))
(defparameter *address* #(127 0 0 1))
(defparameter *port* 4242)

(defun print-to-helmet (string)
  (socket-send *socket* string nil :address `(,*address* ,*port*) ))


(defun clear-helmet ()
  (print-to-helmet (format nil "~A[H~@*~A[J" #\escape)))
