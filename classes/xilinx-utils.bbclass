# Copyright (C) 2011, Adrian Alonso - SecretLab Technologies
# Released under the MIT license (see packages/COPYING)
# Xilinx Utils: A set of helper funtions

def find_board(a, d):
    # Given a xps project path return the target board model
    xps_path = a
    xps_proj = xps_path + '/system.mhs'
    xps_hwd = file(xps_proj, 'r')

    for l in xps_hwd:
        if "Target Board" in l:
            target = l
            break

    board = target.split()
    
    return board[6].lower()
