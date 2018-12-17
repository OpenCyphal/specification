#!/usr/bin/env python3

import os
import sys
import pydsdl
from fnmatch import fnmatch
from functools import partial
from collections import OrderedDict

SOURCE_ROOT_DIRECTORY = os.path.abspath(os.path.dirname(__file__))

ROOT_NAMESPACE_SUPERDIRECTORY = os.path.join(SOURCE_ROOT_DIRECTORY, 'dsdl')


sys.stderr = sys.stdout


def die(why: str) -> None:
    print(why, file=sys.stderr)
    exit(1)


def escape(s: str) -> str:
    return s.replace('_', r'\_')


def render_dsdl_definition(t: pydsdl.data_type.CompoundType) -> str:
    def bit_to_byte(val: tuple) -> tuple:
        return tuple((x + 7) // 8 for x in val)

    def bit_to_can(val: tuple, mtu: int) -> tuple:
        def once(x: int) -> int:
            true_mtu = mtu - 1      # Minus one accounts for the tail byte
            x = (x + 7) // 8        # To bytes
            if x <= true_mtu:
                return 1
            else:
                return (x + 2 + (true_mtu - 1)) // true_mtu     # Plus two for Transfer CRC

        return tuple(once(x) for x in val)

    def rlen_group(blr: tuple) -> list:
        return [
            str(x[0]) if x[0] == x[1] else ('[%d, %d]' % x)
            for x in [
                blr,
                bit_to_byte(blr),
                bit_to_can(blr, 8),
                bit_to_can(blr, 64),
            ]
        ]

    if isinstance(t, pydsdl.data_type.ServiceType):
        length_table_rows = 'Request length  &' + '&'.join(rlen_group(t.request_type.bit_length_range)) + r'\\' +\
                            'Response length &' + '&'.join(rlen_group(t.response_type.bit_length_range)) + r'\\'
    else:
        length_table_rows = 'Message length &' + '&'.join(rlen_group(t.bit_length_range)) + r'\\'

    minted_params = r'fontsize=\scriptsize, numberblanklines=true, baselinestretch=0.9, autogobble=false'
    return '\n'.join([
        r'{\footnotesize',
        r'\begin{tabu}{|r|c c c c|}\hline',
        r'Length unit & Bit & Byte (octet) & CAN MTU 8 & CAN MTU 64 \\\hline',
        length_table_rows,
        r'\hline\end{tabu}',
        r'}',
        r'\pagebreak[2]{}',    # This is needed to discourage page breaks within the listings
        r'\begin{minted}[%s]{python}' % minted_params,
        open(t.source_file_path).read(),
        r'\end{minted}',
    ])


try:
    pattern = sys.argv[1]
except IndexError:
    die('Expected full type name glob, e.g., "uavcan.node.Heartbeat" or "uavcan.file.*"')

# Find out which namespace directories to parse
root_namespaces = list(filter(os.path.isdir,
                              map(partial(os.path.join, ROOT_NAMESPACE_SUPERDIRECTORY),
                                  os.listdir(ROOT_NAMESPACE_SUPERDIRECTORY))))

# Parse all namespaces and join the results into one big list
parsed_types = sum([
    pydsdl.parse_namespace(ns,
                           lookup_directories=root_namespaces,
                           skip_assertion_checks=True)
    for ns in root_namespaces
], [])

# Filter according to the specified pattern
matching = list(filter(lambda t: fnmatch(t.full_name, pattern), parsed_types))
if not matching:
    die('No types match the pattern: %s' % pattern)

# Sort alphabetically and by version
matching = list(sorted(matching, key=str))

# Group by namespace and by type name (i.e., all versions grouped together by name)
grouped = OrderedDict()
for t in matching:
    grouped.setdefault(t.namespace, OrderedDict()).setdefault(t.full_name, []).append(t)

# Render short reference
print(r'{\footnotesize\setlength{\tabulinesep}{-2pt}\setlength{\extrarowsep}{-2pt}\parindent=-\leftskip')
print(r'\begin{longtabu}{|X r l l|}\rowfont{\bfseries}\hline')
print(r'Namespace tree & FPID & Sect. & Full name \\\hline')
prefix = '.'
for t in matching:
    # Walk up and down the tree levels, emitting tree mark rows in the process
    current_prefix = '.' + t.namespace + '.'
    while prefix != current_prefix:
        if current_prefix.startswith(prefix):
            new_comp = current_prefix[len(prefix):].strip('.').split('.')[0]
            print(r'\pagebreak[2]{}')       # Hint LaTeX that it's a good place to begin a new page if necessary
            print(r'\qquad{}' * (prefix.count('.') - 1),
                  r'\texttt{%s}' % escape(new_comp), r'& & & \\')
            prefix += new_comp
        else:
            prefix = '.' + '.'.join(prefix.strip('.').split('.')[:-1])

        prefix += '.'

    print(r'\nopagebreak[4]{}')             # Allow page breaks only when switching namespaces
    print(r'\qquad{}' * prefix.count('.'), r'\texttt{%s}' % t.short_name, '&',
          t.fixed_port_id if t.has_fixed_port_id else '', '&',
          r'\ref{sec:dsdl:%s} &' % t.full_name,
          r'\texttt{%s} \\' % escape(t.full_name))

print(r'\hline\end{longtabu}')
print(r'}')

# Render definitions
for namespace, children in grouped.items():
    print(r'\clearpage\section{%s}' % escape(namespace))
    print(r'\label{sec:dsdl:%s}' % namespace)

    for full_name, versions in children.items():
        is_service = isinstance(versions[0], pydsdl.data_type.ServiceType)

        print(r'\pagebreak[3]{}')
        print(r'\subsection{%s}' % full_name.split(pydsdl.data_type.CompoundType.NAME_COMPONENT_SEPARATOR)[-1])
        print(r'\label{sec:dsdl:%s}' % full_name)
        print(r'Full %s type name: {\bfseries\texttt{%s}}' %
              ('service' if is_service else 'message', escape(full_name)))

        for t in versions:
            title = 'Version %d.%d' % t.version

            if t.has_fixed_port_id:
                service_or_subject = 'service' if is_service else 'subject'
                title += ', fixed %s ID %d' % (service_or_subject, t.fixed_port_id)

            if t.deprecated:
                title += ', DEPRECATED'

            print(r'\subsubsection{%s}' % title)
            print(render_dsdl_definition(t))
