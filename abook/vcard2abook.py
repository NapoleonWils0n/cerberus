#!/usr/bin/env python3
# coding=utf-8
"""
I hereby put this file in the public domain.
"""

#from __future__ import absolute_import, print_function, unicode_literals, division
import argparse
import configparser

class Contact(object):
    def __init__(self):
        self.tels = []
        self.emails = []
        self.name = None
        self.birthday = None
        self.address = None
    pass

def parse_contact(lst):
    c = Contact()
    for li in lst:
        if li.startswith(' '):
            continue
        term, value = li.split(':', 1)
        if term == 'BDAY':
            c.birthday = value
        elif term == 'FN':
            c.name = value
        elif term.startswith('ADR;'):
            c.address = value.strip(';')
        elif term.startswith('TEL;'):
            c.tels.append(value)
        elif term.startswith('EMAIL;'):
            c.emails.append(value)
    return c


def parse_vcard_file(file_path):
    raw_list = []
    current = None
    with open(file_path, encoding='UTF-8') as f:
        for line in f.readlines():
            line = line.rstrip() # strip \r\n
            if line == 'BEGIN:VCARD':
                current = list()
            elif line == 'END:VCARD':
                if current is not None:
                    raw_list.append(current)
                    current = None
            else:
                if current is not None:
                    current.append(line)
    return raw_list


def write_contacts(contacts, output):
    cp = configparser.RawConfigParser()
    cp.add_section('format')
    cp.set('format', 'program', 'abook')
    cp.set('format', 'version', '0.6.0pre2')

    for c in contacts:
        sec = str(contacts.index(c))
        cp.add_section(sec)

        cp.set(sec, 'name', c.name)
        if c.address is not None:
            cp.set(sec, 'address', c.address)
        if len(c.emails) > 0:
            cp.set(sec, 'email', ','.join(c.emails))
        if len(c.tels) > 0:
            for t in zip(['mobile', 'phone', 'workphone'], c.tels):
                a, b = t
                cp.set(sec, a, b)
        if c.birthday is not None:
            cp.set(sec, 'custom1', 'birthday ' + c.birthday)

    with open(output, mode='w') as fd:
        cp.write(fd, space_around_delimiters=False)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', required=True, help='vcard file name', \
            dest='vcard')
    parser.add_argument('-o', default='addressbook', dest='output', \
            help='output file name')
    args = parser.parse_args()
    rawlst = parse_vcard_file(args.vcard)
    contacts = []
    for r in rawlst:
        c = parse_contact(r)
        if c.name is not None:
            contacts.append(c)
        else:
            print("Error: contact with no name")
    
    write_contacts(contacts, args.output)

if __name__ == '__main__':
    main()

