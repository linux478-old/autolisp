;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Command:     MM
;;; Description: alias for the mirror command
;;; Return:      NONE
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun C:MM ()
  (command "mirror")
  (princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Command:     MM1
;;; Description: mirror horizontally from a point
;;; Return:      NONE
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun c:MM1 ()
  (if
    (and
      (setq ss (ssget))
      (setq pt (getpoint "\nClick point on mirror line: "))
    )
    (MP:Command->Mirror ss pt (list (+ 1 (car pt)) (cadr pt)) nil)
  )
  (princ)
) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Command:     MM2
;;; Description: mirror vertically from a point
;;; Return:      NONE
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun c:MM2 ()
  (if
    (and
      (setq ss (ssget))
      (setq pt (getpoint "\nClick point on mirror line: "))
    )
    (MP:Command->Mirror ss pt (list (car pt)(+ 1 (cadr pt))) nil)
  )
  (princ)
) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function:    MP:Command->Mirror
;;; Description: mirror a selection set
;;; Return:      NONE
;;; Example:     (MP:Command->Mirror (SSGET "ALL") '(0 0) '(0 1) nil)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MP:Command->Mirror (
                            ss ; selection set
                            pt1 ; first point on the mirror line
                            pt2 ; second point on the mirror line
                            erase ; nil to copy selection set otherwise erase
                            /
                            #setting
                          )
  (setq #setting (getvar 'cmdecho))
  (setvar 'cmdecho 0)
  (command "mirror"
           ss
           ""
           "_NON" pt1
           "_NON" pt2
           (if (null erase) "No" "Yes")
  )
  (setvar 'cmdecho #setting)
  (princ)
)
