
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


(defun println-to-helmet (string)
  (let ((sock-stream (socket-make-stream
		 *socket*
		 :output t
		 :buffering :none)))
    (format sock-stream "~a~C" string #\linefeed)
    (force-output sock-stream)))



(defun clear-helmet ()
  (println-to-helmet (format nil "~A[H~@*~A[J" #\escape)))
