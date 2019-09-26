@echo off
setlocal enableextensions enabledelayedexpansion

set "ARG=%~1"
ren "%ARG%" "%ARG: =%"