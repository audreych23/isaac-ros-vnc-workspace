#!/bin/bash

# 啟動 supervisor 來管理 x11vnc (在背景運行)
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &

# 輸出初始化完成訊息
echo "Custom VNC services initialized in background"
