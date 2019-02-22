(mapcar
  '(lambda (cmd dem)
     (eval (list 'defun
		 cmd
		 nil
		 (list 'MP:OSnap->MidOfPoints dem)
		 )
	   )
     )
  '(c:mpt2 c:mpt4 c:mpt5)
  '(2 4 5)
)
(defun MP:OSnap->MidOfPoints ( dem / pt1 pt2)
   (if (and
          (= (getvar "cmdactive") 1)
          (setq pt1 (getpoint "\nFirst point: "))
          (setq pt2 (getpoint pt1 "\nSecond point: "))
       )
       (command 
          "_non" 
	  (if (= dem 2)
		  (list
		     (/ (+ (car pt1) (car pt2)) dem)
		     (/ (+ (cadr pt1) (cadr pt2)) dem)
		     (/ (+ (caddr pt1) (caddr pt2)) dem)
		  )
		  (list
		     (+ (/ (- (car pt2) (car pt1)) dem) (car pt1))
                     (+ (/ (- (cadr pt2) (cadr pt1)) dem) (cadr pt1))
        	     (+ (/ (- (caddr pt2) (caddr pt1)) dem) (caddr pt1))
		  )
		  )
       )
   )
   (princ)
)
