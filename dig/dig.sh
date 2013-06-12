#!/bin/bash

# =======
# = dig =
# =======

dig mx hak5.org

#zone transfer
dig -t AXFR hak6.org @ns1.zoneedit.com