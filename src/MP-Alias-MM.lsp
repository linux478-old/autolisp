;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function:    MP:Command->Mirror
;;; Description: alias for the mirror command
;;; Return:      NONE
;;; Example:     (MP:Command->Mirror (SSGET "ALL") '(0 0) '(0 1) nil)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MP:Command->Mirror (
                            ss ; selection set
                            pt1 ; first point on the mirror line
                            pt2 ; second point on the mirror line
                            copy ; nil to copy selection set otherwise erase
                            /
                            #setting
                          )
  (setq #setting (getvar 'cmdecho))
  (setvar 'cmdecho 0)
  (command 
    "_mirror" 
    ss
    ""
    pt1
    pt2
    (if (null copy) "Yes" "No")
  )
  (setvar 'cmdecho #setting)
  (princ)
)
