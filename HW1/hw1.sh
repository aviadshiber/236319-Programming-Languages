#!/bin/bash
wget -q -O - 'cs.technion.ac.il/courses/all/by-number/' | grep -Eo '[0-9]+.+<td>(.+Project <\/td>|.{0,7}Project.+).+#EDEDED>(<a href.+ |<img src.+)' | sed -re 's/<\/td><td width.+//g' | sed -re 's/<\/td><td>//g'