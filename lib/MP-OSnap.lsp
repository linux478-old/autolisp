;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Command: FROM
;;; Description: Finds a new point by keeping track of previous point
;;; Depends On: MP:OSnap->Continuous
;;; Return: Point
;;; Notes: This command is meant to be used transparently in a command
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun C:From ()
  (MP:OSnap->ContinuousPoints)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function: MP:OSnap->Continuous
;;; Description: Continuous get a point from the previous point
;;; Return: Point
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MP:OSnap->ContinuousPoints ( / pt1 pt2)
  ; save the first point
  (setq pt1 (getpoint "\nPoint"))
  (while (setq pt2 (getpoint pt1 "\nNext Point: "))
    ; save the new point
    (setq pt1 pt2)
  )
  ; return the save point
  (command "_non" pt1)
)
(mapcar
  '(lambda (cmd dem)
     (eval (list 'defun
		 cmd
		 nil
		 (list 'MP:OSnap->MidOfPoints dem)
		 )
	   )
     )
  '(c:mpt2 c:mpt3 c:mpt4 c:mpt5)
  '(2 3 4 5)
)
(defun MP:OSnap->MidOfPoints ( dem / pt1 pt2)
   (if (and
          (= (getvar "cmdactive") 1)
          (setq pt1 (getpoint "\nFirst point: "))
          (setq pt2 (getpoint pt1 "\nSecond point: "))
       )
       (command 
          "_non"
	    (list
	      (+ (/ (- (car pt2) (car pt1)) dem) (car pt1))
              (+ (/ (- (cadr pt2) (cadr pt1)) dem) (cadr pt1))
              (+ (/ (- (caddr pt2) (caddr pt1)) dem) (caddr pt1))
            )
	)
   )
   (princ)
)
