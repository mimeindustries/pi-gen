#!/bin/bash -e

on_chroot << EOF
systemctl enable mearm-control
systemctl enable headlesspi-wetty
EOF

