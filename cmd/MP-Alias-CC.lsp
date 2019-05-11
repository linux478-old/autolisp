; alias command for a two point circle
(defun c:cc ()
  (command "circle"
           "2p"
           pause
           pause
  )
  (princ)
)
