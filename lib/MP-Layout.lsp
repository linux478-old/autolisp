(princ "\nLoading MP-Layout ")
(princ ".")
(defun MP:Layout->load ()
  (princ "")
)
(princ ".")
(defun MP:Layout->isFocus ()
  (= 1 (getvar 'cvport))
); defun
(princ ".")
(defun MP:Layout->isModel ()
  (= "MODEL" (strcat (getvar 'ctab)))
); defun
(princ ".")
(defun MP:Layout->setFocus ()
  (setvar 'cvport 1)
); defun
(princ ".")
(defun MP:Layout->setViewportLayers ( / n)
  (if (and
        (not (MP:Layout->isModel))
        (not (MP:Layout->isFocus))
      )
      (progn
        (MP:Entity->layer (setq n (strcat "delete me%%--" (substr (getvar 'ctab) 1 2) "C-delete-me")))
        (command "vplayer"
                 "freeze"
                 "*"
                 "current"
                 "thaw" 
                 (strcat "*%%--*" (substr (MP:Layout->getName) 1 2) "*")
                 "current"
                 "color"
                 "7"
                 "*"
                 "current"
                 "")
        (cond
          ((= (getvar 'ctab) "MEZ") (command "vplayer" "thaw" "*%%--*ZB*" "current" ""))
          ((= (getvar 'ctab) "RD MEZZANINE") (command "vplayer" "thaw" "*%%--*ZC*" "current" ""))
          ((= (getvar 'ctab) "RD THIRD FLOOR") (command "vplayer" "thaw" "*%%--*ZD*,PW-ROOM-IDEN%%--PH" "current" ""))
          ((= (getvar 'ctab) "PHARMA 3") (command "vplayer" "thaw" "*%%--*ZA*" "current" ""))
          ((= (getvar 'ctab) "PW 2") (command "vplayer" "thaw" "*%%--*ZE*" "current" ""))
        )
        (command "vplayer"
                 "removeoverrides"
                 "color"
                 (strcat "*%%--*" (substr (MP:Layout->getName) 1 2) "c*")
                 "current"
                 ""
                 "-laydel"
                 "name"
                 n
                 ""
                 "yes"
      )
    )
  )
); defun
(princ " [Done]")
(princ)

