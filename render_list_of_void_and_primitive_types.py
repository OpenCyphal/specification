#!/usr/bin/env python
#
# This script simply outputs the full set of void and primitive types ordered by bit length.
#

print(r'\begin{enumerate}')
for i in range(1, 65):
    print(' ' * 4 + r'\item ' + r' \quad{} '.join(filter(None, [
        (r'\verb|void%-3d|') % i,
        (r'\verb|int%-3d|'   % i) if i >= 2 else None,
        (r'\verb|uint%-3d|'  % i) if i >= 1 else None,
        (r'\verb|float%-3d|' % i) if i in (16, 32, 64) else None,
        (r'\verb|bool|') if i == 1 else None,
    ])))
print(r'\end{enumerate}')
