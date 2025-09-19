#!/bin/bash
hexo clean && hexo g && hexo d
git add . && git commit -m "updata $(date)" && git push
