
(defpackage :helmet
  (:use :cl :sb-bsd-sockets))

(in-package :helmet)


(defun udp ()
  (make-instance
   'inet-socket :type :datagram :protocol :udp))


(defvar *all-ips* #(0 0 0 0))
(defvar *app-port* 4242)
(defparameter *socket* (udp))
(defvar *print-thread* nil)

(defun start ()
  (socket-bind *socket* *all-ips* *app-port*)
  (spawn-print-loop))

(defun spawn-print-loop ()
  (let ((sock-stream (socket-make-stream
		 *socket*
		 :input t
		 :buffering :none))
	(top-level *standard-output*))
    (setf *print-thread*
	  (sb-thread:make-thread
	   #'(lambda ()
	       (loop do
		 (format top-level 
			 "~@[~C~]" (read-char sock-stream))))))))

(start)




