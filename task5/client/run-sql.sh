#!/bin/bash

echo "! Reminder: password is password"
psql -f $1 -U user -h 127.0.0.1 -p 5432 -v ON_ERROR_STOP=1