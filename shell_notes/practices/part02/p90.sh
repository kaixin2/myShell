#!/bin/bash
sed -i '/^SELINUX/s/=.*/=disabled/' /etc/selinux/config