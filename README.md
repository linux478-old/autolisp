# MP Suite

#### Collection of code and settings to optimize AutoCAD for your workflow

## Purpose

As a paid CAD Technician and programming enthusiast, I saw my co-workers being slave to the AutoCAD application.
The application was not setup to meet their workflows.  This project will focus on changable settings and scripts
to control the AutoCAD application.

## User Commands

File            | Command    | Usage | Description
--------------- | -------    | ----- | -----------
MP-Alias-C.lsp  | C          |       | copy command the multiple mode selected
MP-Alias-CC.lsp | CC         |       | 2 point circle command
MP-Alias-D.lsp  | D          |       | dist command
MP-Alias-MM.lsp | MM         |       | mirror command
MP-Alias-MM.lsp | MM1        |       | mirror horizontally from a point
MP-Alias-MM.lsp | MM2        |       | mirror vertically from a point
MP-Alias-RR.lsp | RR         |       | rotate command
MP-Alias-RR.lsp | RR1        |       | rotate command set at 90 degrees
MP-Alias-RR.lsp | RR2        |       | rotate command set at 180 degrees
MP-Alias-RR.lsp | RR3        |       | rotate command set at 270 degrees
MP-Alias-RR.lsp | RR4        |       | rotate command set at 45 degrees
MP-Alias-Z.lsp  | Z          |       | pline command
vp-outline.lsp  | VP-OUTLINE |       | outline viewport in model space from paper space
                
## Transparent Commands

File                          | Command | Usage | Description
----------------------------- | ------- | ----- | -----------
MP-OSnap-ContinuousPoints.lsp | FROM    |       | keeps track of previous point
MP-OSnap-MidOfPoints.lsp      | MPT2    |       | mid of 2 points
MP-OSnap-MidOfPoints.lsp      | MPT4    |       | mid of 1/4 points
MP-OSnap-MidOfPoints.lsp      | MPT5    |       | mid of 1/5 points

## Installation

- Get project
  - This can be done thru Cloning or downloading the zip and extracting
- Load the script(s)
  - acaddoc.lsp will dynamically load all the scripts if scripts are in your support directory
  - Need only one or a few scripts
```
(load "PathName\\FileName") or (load "Pathname/FileName")
```

## Development Environment

None.  Just change the code and run the changed file(s) in AutoCAD.

## Built with
- Application
    - [AutoCAD](http://www.autodesk.com)
- Text Editor
    - [Vim](http://www.vim.org)

## Contribute

Please do contribute! Issues and pull requests are welcome.
Thank you for your help improving yours and somebody elses AutoCAD experience.

## License

MIT  © [Michael Phillips](http://github.com/linux478)
