#!/bin/bash
cat >> /etc/security/limits.conf << EOF
* soft nofile 65536
* hard nofile 65536
EOF