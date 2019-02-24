;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Command:     MM
;;; Description: alias for the mirror command
;;; Return:      NONE
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun C:MM ()
  (if 
    (and
      (setq #ss (ssget))
      (setq #pt1 (getpoint "\nClick first point on the mirror line: "))
      (setq #pt2 (getpoint #pt1 "\nClick second point on the mirror line: "))
      (setq #erase (if (setq #erase (member (getstring "\nErase selection set? [Y/N] <N>: ") '("YES" "Y" "y" "yes"))) (car #erase) "No"))
    )
    (MP:Command->Mirror #ss #pt1 #pt2 (if (= #erase "No") nil #erase)) 
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
