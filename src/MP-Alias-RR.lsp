;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: mapcar
;;; Variables:
;;;   cmd: user command to type
;;;   ang: angle of rotation or nil for user input
;;; Notes:
;;;   line after nil is the function to be executed in the new command functions
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(mapcar
  '(lambda (cmd ang)
     (eval (list 'defun
		 cmd
		 nil
		 (list 'MP:Prompt->SelectionSetPointAngle 'MP:Command->Rotate nil nil ang)
		 )
	   )
     )
  '(c:RR c:RR1 c:RR2 c:RR3 c:RR4) ; user commands created
  '(nil 90 180 270 45) ; angles for each of the command with nil asking the user
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function:    MP:Command->Rotate
;;; Description: Rotate a given selection set around a point so many degrees
;;; Return:      NONE
;;; Example:     (MP:Command->Rotate (SSGET) (GETPOINT "\nClick Basepoint: ") 60)
;;; Example:     (MP:Command->Rotate (SSGET) (GETPOINT "\nClick Basepoint: ") nil)
;;; Example:     (MP:Command->Rotate (SSGET "ALL") '(0 0) nil)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MP:Command->Rotate (
                            ss ; selection set
                            pt ; basepoint
                            ang ; rotation angle in degrees
                            /
                            #setting
                          )
  (setq #setting (getvar 'cmdecho))
  (setvar 'cmdecho 0)
  (command 
    "_rotate" 
    ss
    ""
    pt
    (if (null ang) (getreal "\nEnter angle: ") ang)
  )
  (setvar 'cmdecho #setting)
  (princ)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function:    MP:Prompt->SelectionSetPointAngle
;;; Description: Prompts on the command line for objects and point and then
;;;              executes a function
;;; Return:      None
;;; Example:     
;;;   (MP:Prompt->SelectionSetPointAngle MP:Command->Rotate nil nil nil)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MP:Prompt->SelectionSetPointAngle (
                                       func ; function symbol
                                       ss ; selection set
                                       pt ; point 
                                       ang ; real angle
                                    )
  (if
    (and
      (setq ss (if (null ss) (ssget) ss))
      (setq pt (if (null pt) (getpoint "\nClick Basepoint: ") pt))
      (setq ang (if (null ang) (getreal "\nEnter Angle: ") ang))
    )
    (func ss pt ang)
  )
  (princ)
)
