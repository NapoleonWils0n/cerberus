#!/bin/sh

# mysql injection
SELECT * FROM SOMETABLE WHERE UID = ' ' AND PWD = ' '

SELECT * FROM SOMETABLE WHERE UID = ' ' OR 1=1--' AND PWD = ' '
