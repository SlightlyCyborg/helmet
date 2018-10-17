(ql:quickload :usocket)
(defpackage :helmet
  (:use :cl :usocket))

(in-package :helmet)


(defvar *all-ips* #(0 0 0 0))
(defvar *app-port* 4242)
(defvar *print-thread* nil)
(defvar *socket* nil)

(defun start ()
  (setf
   *socket*
   (socket-connect nil nil 
		   :local-port *app-port*
		   :protocol :datagram))
  (start-print-loop))

(defun start-print-loop ()
  (loop do
    (format t "~a" (map 'string #'code-char
			(remove-if
			 #'zerop
			 (socket-receive *socket* nil 5200))))
    (finish-output *standard-output*)))

(start)




