from copy import copy
import traceback
from pyjsparser import PyJsParser
import os
import re
from datetime import datetime
import argparse


main_folder = '/media/namnam/namnam/'
sites_folder = main_folder + 'Sites/'
js_files = main_folder + 'parsed.csv'
site_list = main_folder + 'dowloaded_sites.csv'
output_file = main_folder + 'result.csv'
# limit of the file size for getting parsed (1 MB)
file_limit = 1048576

i = 0
temp_sitename = ''

result_k = []
path_k = []
z = 0

# the blacklist of common .js libraries; needs to be in lowercase
# read more: https://www.javascripting.com
b_files = ['jquery', 'jqx', 'lazyload', 'angular', 'ember', 'addthis',
           'unified', 'prototype', 'aculo', 'qooxdoo', 'redux',
           'smartclient', 'sprout', 'wakanda', 'zkoss', 'webix',
           'jqwidget', 'dojo', 'dhtmlx', 'enyo', 'ext', 'google',
           'mootool', 'openui', 'rocket', 'font', 'analytics', 'video',
           'onesignalsdk', 'recaptcha', 'vue', 'react', 'node',
           'chaplin', 'next', 'cannon' 'd3', 'velocity', 'chr',
           'three', 'chart', 'iconic', 'video', 'polymer', 'modernizr',
           'jplayer', 'vids', 'svg', 'paper', 'fabric', 'paper',
           'socket', 'snap', 'device', 'animate', 'reveal', 'typed',
           'nuxt', 'electron', 'sea', 'lozad', 'layzr', 'lazysizes',
           'mustache', 'jade', 'page', 'howler', 'tone', 'audio', 'midi',
           'quill', 'cleave', 'selectize', 'parsley', 'sdk']


# blacklist of sites (not-fully-downloaded)
b_sites = []
# list of previously parsed sites and written in 'output_file'
p_sites = []
# list of the methods the program needs to look for during parsing
methods = []
# localStorage (LST)
methods_LST = ['setItem', 'getItem', 'removeItem']
# WebSQL (WSQ)
methods_WSQ = ['executeSql']
submethods_WSQ = ['executeSql_ins', 'executeSql_upd', 'executeSql_del']
# IndexedDB (IDB)
methods_IDB = ['add', 'get', 'getAll', 'delete']

counter = {
    'setItem': {'FunctionDeclaration': 0,
    			'FunctionExpression': 0,
                'IfStatement': 0,
                'ForStatement': 0,
                'WhileStatement': 0,
                'DoWhileStatement': 0,
                'SwitchStatement': 0,
                'TryStatement': 0,
                'VariableDeclarator': 0,
                'BlockStatement': 0,
                'TotalS': 0,
                'Total': 0
                },
    'getItem': {'FunctionDeclaration': 0,
                'FunctionExpression': 0,
                'IfStatement': 0,
                'ForStatement': 0,
                'WhileStatement': 0,
                'DoWhileStatement': 0,
                'SwitchStatement': 0,
                'TryStatement': 0,
                'VariableDeclarator': 0,
                'BlockStatement': 0,
                'TotalS': 0,
                'Total': 0
                },
    'removeItem': {'FunctionDeclaration': 0,
                   'FunctionExpression': 0,
                   'IfStatement': 0,
                   'ForStatement': 0,
                   'WhileStatement': 0,
                   'DoWhileStatement': 0,
                   'SwitchStatement': 0,
                   'TryStatement': 0,
                   'VariableDeclarator': 0,
                   'BlockStatement': 0,
                   'TotalS': 0,
                   'Total': 0
                   },
    'executeSql_ins': {'FunctionDeclaration': 0,
                       'FunctionExpression': 0,
                       'IfStatement': 0,
                       'ForStatement': 0,
                       'WhileStatement': 0,
                       'DoWhileStatement': 0,
                       'SwitchStatement': 0,
                       'TryStatement': 0,
                       'VariableDeclarator': 0,
                       'BlockStatement': 0,
                       'TotalS': 0,
                       'Total': 0
                        },
    'executeSql_upd': {'FunctionDeclaration': 0,
                       'FunctionExpression': 0,
                       'IfStatement': 0,
                       'ForStatement': 0,
                       'WhileStatement': 0,
                       'DoWhileStatement': 0,
                       'SwitchStatement': 0,
                       'TryStatement': 0,
                       'VariableDeclarator': 0,
                       'BlockStatement': 0,
                       'TotalS': 0,
                       'Total': 0
                        },
    'executeSql_del': {'FunctionDeclaration': 0,
                       'FunctionExpression': 0,
                       'IfStatement': 0,
                       'ForStatement': 0,
                       'WhileStatement': 0,
                       'DoWhileStatement': 0,
                       'SwitchStatement': 0,
                       'TryStatement': 0,
                       'VariableDeclarator': 0,
                       'BlockStatement': 0,
                       'TotalS': 0,
                       'Total': 0
                        },
    'add': {'FunctionDeclaration': 0,
            'FunctionExpression': 0,
            'IfStatement': 0,
            'ForStatement': 0,
            'WhileStatement': 0,
            'DoWhileStatement': 0,
            'SwitchStatement': 0,
            'TryStatement': 0,
            'VariableDeclarator': 0,
            'BlockStatement': 0,
            'TotalS': 0,
            'Total': 0
           },
    'get': {'FunctionDeclaration': 0,
            'FunctionExpression': 0,
            'IfStatement': 0,
            'ForStatement': 0,
            'WhileStatement': 0,
            'DoWhileStatement': 0,
            'SwitchStatement': 0,
            'TryStatement': 0,
            'VariableDeclarator': 0,
            'BlockStatement': 0,
            'TotalS': 0,
            'Total': 0
           },
    'getAll': {'FunctionDeclaration': 0,
               'FunctionExpression': 0,
               'IfStatement': 0,
               'ForStatement': 0,
               'WhileStatement': 0,
               'DoWhileStatement': 0,
               'SwitchStatement': 0,
               'TryStatement': 0,
               'VariableDeclarator': 0,
               'BlockStatement': 0,
               'TotalS': 0,
               'Total': 0
              },
    'delete': {'FunctionDeclaration': 0,
               'FunctionExpression': 0,
               'IfStatement': 0,
               'ForStatement': 0,
               'WhileStatement': 0,
               'DoWhileStatement': 0,
               'SwitchStatement': 0,
               'TryStatement': 0,
               'VariableDeclarator': 0,
               'BlockStatement': 0,
               'TotalS': 0,
               'Total': 0
              },
    'TotalIndexedDB': 0,
    'TotalWebSQL': 0,
    'TotalLocalStorage': 0,
    'TotalFiles': 0
    }


# prints on screen
def OnScreen(FLAG, text, color):
    # define restart
    END = '\x1b[0m'
    # define colors (background:foreground)
    if color == 'BO':  # blue:orange
        color = '\x1b[0;33;44m'
    elif color == 'PB':  # purple:black
        color = '\x1b[0;30;45m'
    elif color == 'RW':  # red:white
        color = '\x1b[1;37;41m'
    elif color == 'WR':  # white:red
        color = '\x1b[7;37;41m'
    elif color == 'gY':  # green:yellow
        color = '\x1b[1;33;42m'
    elif color == 'gW':  # green:white
        color = '\x1b[7;30;47m'
    elif color == 'GW':  # grey:white
        color = '\x1b[6;37;42m'
    elif color == 'Gg':  # grey:green
        color = '\x1b[7;30;46m'
    else:  # normal
        color = ''
        END = ''

    # print in the middle; begins and ends with u'\u2551'
    row, col = os.popen('stty size', 'r').read().split()
    sp = int(col) - len(text)
    if sp % 2 != 0:
        sp0 = sp // 2
        sp1 = sp // 2 - 1
        sp20 = sp0 + (sp % 2)
        sp21 = sp1 + (sp % 2)
    else:
        sp0 = sp20 = sp / 2
        sp1 = sp21 = sp / 2 - 1

    if FLAG == 'top':
        print(u'\u2554'.encode('utf-8') + (int(col)-2)
              * u'\u2550'.encode('utf-8') + u'\u2557'.encode('utf-8'))
    elif FLAG == 'border':
        print(u'\u2551'.encode('utf-8') + sp1 * ' ' + color + text + END
              + sp21 * ' ' + u'\u2551'.encode('utf-8'))
    elif FLAG == 'b-center':
        print(u'\u255A'.encode('utf-8') + sp1 * u'\u2550'.encode('utf-8')
              + color + text + END + sp21 * u'\u2550'.encode('utf-8')
              + u'\u255D'.encode('utf-8'))
    elif FLAG == 'b-right':
        print(u'\u255A'.encode('utf-8') + (sp-2) * u'\u2550'.encode('utf-8')
              + color + text + END + u'\u255D'.encode('utf-8'))
    elif FLAG == 'center':
        print(sp0 * ' ' + color + text + END + sp20 * ' ')
    elif FLAG == 'right':
        print(sp * ' ' + color + text + END)
    else:
        print(color + text + END)


# writes the info to csv file
def writeToCSVFile(site, method, data, FLAG):
    if os.stat(output_file).st_size == 0:
        F = True
    else:
        F = False
    with open(output_file, "a+") as output:
        """
        if the file is empty then it writes the first line (header).
        The followings are the legends of the abbreviations:
        FuD: Function Declaration
        FuE: Function Expretion
        IfS: If Statement
        For: For Statement
        Whi: While Statement
        DoW: Do-While Statement
        Swt: Switch Statement
        Try: Try Statement
        Var: Variable Declarator
        Blo: Block Statement
        Tot: Total occurence of method in a file
        ToS: Total occurence of method in statements of a file
        """
        if F:
            output.write('DateTime,Site_Name,TotalFiles,')
            output.write('TotalLocalStorage,TotalWebSQL,TotalIndexedDB,')
            # localStorage (LST) - setItem (set)
            output.write('LST_set_FuD,LST_set_IfS,LST_set_For,LST_set_Whi,')
            output.write('LST_set_DoW,LST_set_Swt,LST_set_Try,LST_set_Var,')
            output.write('LST_set_FuE,LST_set_Blo,LST_set_Tot,LST_set_ToS,')
            # localStorage (LST) - getItem (get)
            output.write('LST_get_FuD,LST_get_IfS,LST_get_For,LST_get_Whi,')
            output.write('LST_get_DoW,LST_get_Swt,LST_get_Try,LST_get_Var,')
            output.write('LST_get_FuE,LST_get_Blo,LST_get_Tot,LST_get_ToS,')
            # localStorage (LST) - removeItem (rmv)
            output.write('LST_rmv_FuD,LST_rmv_IfS,LST_rmv_For,LST_rmv_Whi,')
            output.write('LST_rmv_DoW,LST_rmv_Swt,LST_rmv_Try,LST_rmv_Var,')
            output.write('LST_rmv_FuE,LST_rmv_Blo,LST_rmv_Tot,LST_rmv_ToS,')
            # WebSQL (WSQ) - executeSql.INSERT (ins)
            output.write('WSQ_ins_FuD,WSQ_ins_IfS,WSQ_ins_For,WSQ_ins_Whi,')
            output.write('WSQ_ins_DoW,WSQ_ins_Swt,WSQ_ins_Try,WSQ_ins_Var,')
            output.write('WSQ_ins_FuE,WSQ_ins_Blo,WSQ_ins_Tot,WSQ_ins_ToS,')
            # WebSQL (WSQ) - executeSql.UPDATE (upd)
            output.write('WSQ_upd_FuD,WSQ_upd_IfS,WSQ_upd_For,WSQ_upd_Whi,')
            output.write('WSQ_upd_DoW,WSQ_upd_Swt,WSQ_upd_Try,WSQ_upd_Var,')
            output.write('WSQ_upd_FuE,WSQ_upd_Blo,WSQ_upd_Tot,WSQ_upd_ToS,')
            # WebSQL (WSQ) - executeSql.DELETE (del)
            output.write('WSQ_del_FuD,WSQ_del_IfS,WSQ_del_For,WSQ_del_Whi,')
            output.write('WSQ_del_DoW,WSQ_del_Swt,WSQ_del_Try,WSQ_del_Var,')
            output.write('WSQ_del_FuE,WSQ_del_Blo,WSQ_del_Tot,WSQ_del_ToS,')
            # IndexedDB (IDB) - objectStore.add (add)
            output.write('IDB_add_FuD,IDB_add_IfS,IDB_add_For,IDB_add_Whi,')
            output.write('IDB_add_DoW,IDB_add_Swt,IDB_add_Try,IDB_add_Var,')
            output.write('IDB_add_FuE,IDB_add_Blo,IDB_add_Tot,IDB_add_ToS,')
            # IndexedDB (IDB) - objectStore.get (get)
            output.write('IDB_get_FuD,IDB_get_IfS,IDB_get_For,IDB_get_Whi,')
            output.write('IDB_get_DoW,IDB_get_Swt,IDB_get_Try,IDB_get_Var,')
            output.write('IDB_get_FuE,IDB_get_Blo,IDB_get_Tot,IDB_get_ToS,')
            # IndexedDB (IDB) - objectStore.getAll (geA)
            output.write('IDB_geA_FuD,IDB_geA_IfS,IDB_geA_For,IDB_geA_Whi,')
            output.write('IDB_geA_DoW,IDB_geA_Swt,IDB_geA_Try,IDB_geA_Var,')
            output.write('IDB_geA_FuE,IDB_geA_Blo,IDB_geA_Tot,IDB_geA_ToS,')
            # IndexedDB (IDB) - objectStore.delete (del)
            output.write('IDB_del_FuD,IDB_del_IfS,IDB_del_For,IDB_del_Whi,')
            output.write('IDB_del_DoW,IDB_del_Swt,IDB_del_Try,IDB_del_Var,')
            output.write('IDB_del_FuE,IDB_del_Blo,IDB_del_Tot,IDB_del_ToS\n')

        # if it is the beginning of the row
        if FLAG == 'begining':
            output.write(datetime.now().strftime("%Y-%m-%d %H:%M:%S") + ',')
            output.write(site + ',')
            output.write(str(counter['TotalFiles']) + ',')
            output.write(str(counter['TotalLocalStorage']) + ',')
            output.write(str(counter['TotalWebSQL']) + ',')
            output.write(str(counter['TotalIndexedDB']) + ',')
            # print the result on the screen
            OnScreen('none', ' *  ' + site + ' - Total Files        ' +
                      ' -  ' + str(counter['TotalFiles']) + ' ', 'PB')
            OnScreen('none', ' *  ' + site + ' - Total LocalStorage ' +
                      ' -  ' + str(counter['TotalLocalStorage']) + ' '
                      , 'PB')
            OnScreen('none', ' *  ' + site + ' - Total IndexedDB    ' +
                      ' -  ' + str(counter['TotalIndexedDB']) + ' '
                      , 'PB')
            OnScreen('none', ' *  ' + site + ' - Total WebSQL       ' +
                      ' -  ' + str(counter['TotalWebSQL']) + ' ', 'PB')
            """
        write the data of the row for each method in this order:
        'setItem', 'getItem', 'removeItem',
        'executeSql_ins', 'executeSql_upd', 'executeSql_del',
        'add', 'get', 'getAll', 'delete'
        first 3 items are for localStorage
        next 3 items are for WebSQL
        and last 4 items are for IndexedDB
        """
        elif FLAG == 'middle':
            output.write(str(counter[method]['FunctionDeclaration']) + ',')
            output.write(str(counter[method]['IfStatement']) + ',')
            output.write(str(counter[method]['ForStatement']) + ',')
            output.write(str(counter[method]['WhileStatement']) + ',')
            output.write(str(counter[method]['DoWhileStatement']) + ',')
            output.write(str(counter[method]['SwitchStatement']) + ',')
            output.write(str(counter[method]['TryStatement']) + ',')
            output.write(str(counter[method]['VariableDeclarator']) + ',')
            output.write(str(counter[method]['FunctionExpression']) + ',')
            output.write(str(counter[method]['BlockStatement']) + ',')
            output.write(str(counter[method]['Total']) + ',')
            output.write(str(counter[method]['TotalS']) + ',')
            # print the result on the screen for each method
            s = 19 - len(method)
            detail_s = ' \t ({}+{}+{}+{}+{}+{}+{}+{}+{}={}) '.format(
                               str(counter[method]['FunctionDeclaration']),
                               str(counter[method]['FunctionExpression']),
                               str(counter[method]['IfStatement']),
                               str(counter[method]['ForStatement']),
                               str(counter[method]['WhileStatement']),
                               str(counter[method]['DoWhileStatement']),
                               str(counter[method]['SwitchStatement']),
                               str(counter[method]['TryStatement']),
                               str(counter[method]['VariableDeclarator']),
                               str(counter[method]['TotalS']))
            OnScreen('none', ' ~  ' + site + ' - ' + method + s * ' ' +
                     ' -  ' + str(counter[method]['Total']) + detail_s
                     , 'Gg')

        # finalize the row
        elif FLAG == 'end':
            output.write('\n')
            output.close()


# recursively search for the method in the parsed JSON
def FindValues(json, method):
    global z
    x = 0
    try:
        """
        if the json is not a dictionary (dic) then it will be a list
        (array) then apparently each item of it is a dictionarry and it
        will recursively check each of them
        """
        if isinstance(json, list) and json:
            for d in json:
                FindValues(d, method)
                z += 1
        # if it is a dictionary
        elif isinstance(json, dict):
            # get the (key, value) pairs
            for key, value in json.items():
                """
                add the key to the arrey "path".
                "key" is used because the path of reaching a value in a
                dictionary is like the following:
                dic["key1"][0]["key2"]["key3"][1]
                """
                path_k.append(key)
                # if value is not dic but is empty
                if isinstance(value, list) and not value:
                    pass
                    """
                if value is not dic and is not empty then it is a list &
                reaching the value is not possible by e.g. dic["key"];
                dic = {"key1":[{"key2":"value2"}]}
                dic["key1"]["key2"] is not working but
                dic["key1"][0]["key2"] works.
                this part of the code works on the lists in dictionary
                """
                elif isinstance(value, list) and value:
                    for v in value:
                        # add the position of (key, value) to the list
                        path_k.append(x)
                        FindValues(v, method)
                        x += 1
                        path_k.pop()
                    x = 0
                # if value is dictionary
                elif isinstance(value, dict):
                    FindValues(value, method)
                # if value is value and equals the method
                if value == method:
                    result_k.append(z)
                    result_k.append(copy(path_k))
                path_k.pop()

    except Exception as err:
        print('\x1b[1;37;41m{}\x1b[0m'.format(str(err)))
        traceback.print_exc()


"""
find the type of the statement of each method and count the number of
occurance of each
"""
def FindStatements(array, json, method):
    try:
        # walk through the list (array) of paths
        for i in range(0, len(array)):
            # reset the method which is changed to submethod
            if method in submethods_WSQ:
                method = 'executeSql'
            item = ''
            stype = []
            # find the tyep of statement (stype)
            if i % 2 == 0:
                item = json['body'][array[i]]
                try:
                    stype.append(item["type"])
                except:
                    stype.append(' ')
                key = array[i+1]

                """
                if it is WebSQL then it has submethods like DELETE which
                is SQL query.
                first, it needs to remove last 3 keys because of the form
                of JSON that Esprima creates to go to another key which
                is 'arguments' to reach the SQL query.
                it is because 'executeSql' is in (latest keys) 
                ...['expression']['callee']['property']['name']
                while query is in
                ...['expression']['arguments']...
                an example: goo.gl/vNR5Rf
                
                Then, count the number of occurence. The issue is that
                sometimes it has the SQL query in 'raw' key as well
                as 'value' key. So, it can count 2 times. with this
                method, it prevent double count.
                """
                if method == 'executeSql':
                    key.pop()
                    key.pop()
                    key.pop()
                    key.append('arguments')
                    txt = item
                    for k in key:
                        txt = txt[k]
                    if 'INSERT' in str(txt):
                        method = 'executeSql_ins'
                        # count the total number of methods in WebSQL
                        counter['TotalWebSQL'] += 1
                        c = int(round(str(txt).count('INSERT')/2.0))
                        counter[method]['Total'] += c
                    if 'UPDATE' in str(txt):
                        method = 'executeSql_upd'
                        counter['TotalWebSQL'] += 1
                        c = int(round(str(txt).count('UPDATE')/2.0))
                        counter[method]['Total'] += c
                    if 'DELETE' in str(txt):
                        method = 'executeSql_del'
                        counter['TotalWebSQL'] += 1
                        c = int(round(str(txt).count('DELETE')/2.0))
                        counter[method]['Total'] += c
                    key.append(0)

                if method == 'executeSql':
                    continue

                # find the type of each statement
                for j in range(0, len(key)):
                    if isinstance(key[j], int):
                        pass
                    elif isinstance(item[key[j]], dict):
                        item = item[key[j]]
                        try:
                            stype.append(item["type"])
                        except:
                            stype.append(' ')
                    elif isinstance(item[key[j]], list):
                        # record the location of the target in the list
                        loc = key[j+1]
                        item = item[key[j]][loc]
                        try:
                            stype.append(item["type"])
                        except:
                            stype.append(' ')
                    else:
                        item = item[key[j]]
 
                # count the number of occurrence of items
                counter[method]['FunctionDeclaration'] += stype.count('FunctionDeclaration')
                counter[method]['FunctionExpression'] += stype.count('FunctionExpression')
                counter[method]['IfStatement'] += stype.count('IfStatement')
                counter[method]['ForStatement'] += stype.count('ForStatement')
                counter[method]['WhileStatement'] += stype.count('WhileStatement')
                counter[method]['DoWhileStatement'] += stype.count('DoWhileStatement')
                counter[method]['SwitchStatement'] += stype.count('SwitchStatement')
                counter[method]['TryStatement'] += stype.count('TryStatement')
                counter[method]['VariableDeclarator'] += stype.count('VariableDeclarator')
                # counter[method]['BlockStatement'] += stype.count('BlockStatement')
    except Exception as err:
        print('\x1b[1;37;41m{}\x1b[0m'.format(str(err)))
        traceback.print_exc()


# find the time difference
def time_delta(time0):
    time1 = datetime.now()
    delta = round((time1 - time0).total_seconds(), 2)
    now = datetime.now().time().strftime("%H:%M:%S")
    OnScreen('b-right', ' {} ({}s) '.format(now, delta), 'gW')


if __name__ == '__main__':
    # gives options to the user to search among different APIs
    parser = argparse.ArgumentParser()

    parser.add_argument(
                    "-LST", "--localstorage",
                    help="Search for methods of Local Storage API",
                    action="store_true", default=False
                    )
    parser.add_argument(
                    "-WSQ", "--websql",
                    help="Search for methods of WebSQL API",
                    action="store_true", default=False
                    )
    parser.add_argument(
                    "-IDB", "--indexeddb",
                    help="Search for methods of IndexedDB API",
                    action="store_true", default=False
                    )

    args = parser.parse_args()

    """
    based on the selection of the user, it define 'methods' array to
    define the methods it needs to look for
    """
    Flag = False
    if args.localstorage:
        methods.extend(methods_LST)
        Flag = True
    if args.websql:
        methods.extend(methods_WSQ)
        Flag = True
    if args.indexeddb:
        methods.extend(methods_IDB)
        Flag = True
    if not Flag:
        methods.extend(methods_LST + methods_WSQ + methods_IDB)

    # read list of .js/.html files
    with open(js_files, 'r') as js:
        all_js_list = sorted(js.read().splitlines())
        js_list = []
        for js in all_js_list:
            html = js.split(',')[4]
            if html.isdigit() and int(html) >= 1:
                js_list.append(js)


    # create a blackkist of not-fully-downloaded sites
    with open(site_list, 'r') as js:
        sites = sorted(js.read().splitlines())
        for site in sites:
            if site.split(',')[1] != 'website_is_downloaded':
                b_sites.append(site.split(',')[0])

    """
    if result.csv exist, create a list of sites which are already
    parsed to avoid any duplicated parsing. if the file doesn't exist
    will create it as read/write.
    """
    if os.path.isfile(output_file):
        with open(output_file, 'r') as js:
            sites = sorted(js.read().splitlines())
            for site in sites:
                if site.split(',')[1] != 'Site_Name':
                    p_sites.append(site.split(',')[1])
            # remove duplications
            # read more: https://stackoverflow.com/a/7961390/4741225
            p_sites = list(set(p_sites))
            p_sites = sorted(p_sites)

    # start loading each .js/.html file to get parsed
    temp_sitename = js_list[0].split(',')[0]
    for js_f in js_list:
        try:

            """
            remove items of submethods_WSQ from the list and add the
            main method ('executeSql') to find the method.
            """
            smFlag = False
            for sm in submethods_WSQ:
                if sm in methods:
                    smFlag = True
                    methods.pop(methods.index(sm))
            if smFlag:
                methods.extend(methods_WSQ)
            
            time0 = datetime.now()
            i += 1
            # find the location of the file
            js_f = js_f.split(',')
            websiteName = str(js_f[0])
            fileName = str(js_f[5].split('/')[-1].lower())
            f = js_f[5].split('/')[-1].lower()
            # calculate the file size
            file_size = os.stat((sites_folder + js_f[5])).st_size
            fs_in_kb = round(file_size / 1024.0, 1)


            # check if site is already parsed
            if websiteName in p_sites:
                OnScreen('top', 'none', 'none')
                OnScreen('border', js_f[5] + ' (' + str(fs_in_kb)
                          + ' kB)', 'none')
                OnScreen('border', '=== {}/{} =='.format(i, len(js_list)),
                         'BO')
                OnScreen('b-right', '# Already Parsed', 'WR')
                #temp_sitename = js_list[i].split(',')[0]
                continue

            if websiteName == temp_sitename:
                counter['TotalFiles'] += 1
                # print the processing function on the screen
                OnScreen('top', 'none', 'none')
                OnScreen('border', js_f[5] + ' (' + str(fs_in_kb)
                          + ' kB)', 'none')
                OnScreen('border', '=== {}/{} ==++== {} ==='
                          .format(i, len(js_list), datetime.now().
                                  strftime("%Y-%m-%d %H:%M:%S")),
                          'BO')
                # remove files with size greater than the limit
                if (file_size > file_limit):
                    OnScreen('b-right', '% size limit exceeded', 'WR')
                    continue


                # check if the file or site is blacklisted
                if websiteName in b_sites:
                    OnScreen('b-right', '@ blacklisted site', 'WR')
                    continue
                elif any(w in f for w in b_files):
                    OnScreen('b-right', '@ blacklisted file', 'WR')
                    continue

                # prepare the .js/.html for getting parsed
                with open(sites_folder + js_f[5], 'r') as f:
                    js_file = f.read().decode('utf-8')
                # if it is .html, find the <script> tags
                if js_f[5].endswith('.html'):
                    js_file = re.findall('(?si)<script>(.*?)</script>',
                                         js_file)
                    js_file = ''.join(js_file)


                """
                start parsing
                read more: https://github.com/PiotrDabkowski/pyjsparser
                """
                p = PyJsParser()
                parsed = p.parse(js_file)

                # parse the JSON file for each method
                for m in methods:
                    FindValues(parsed['body'], m)
                    if result_k and (m != 'executeSql'):
                        counter[m]['Total'] += len(result_k)/2
                    FindStatements(result_k, parsed, m)
                    # initilize the items
                    result_k = []
                    path_k = []
                    z = 0

                # print the tiem in seconds spent on each file
                time_delta(time0)

            """
            remove 'executeSql' from the list and add submethods, i.e.
            INSERT INTO corresponding key in JSON file to count the
            occurrence.
            """
            if 'executeSql' in methods:
                methods.pop(methods.index('executeSql'))
                methods.extend(submethods_WSQ)

            # if it is the last file of a site listed in parsed.csv
            if websiteName != temp_sitename or i == len(js_list):
                # count the total number of each API regardless its methods
                for m in methods:
                    for key, value in counter[m].items():
                        if key != 'Total' and key != 'TotalS':
                            counter[m]['TotalS'] += value
                # count the total number of methods in LocalStorage
                counter['TotalLocalStorage'] += counter['setItem']['Total']
                counter['TotalLocalStorage'] += counter['getItem']['Total']
                counter['TotalLocalStorage'] += counter['removeItem']['Total']
                # count the total number of methods in IndexedDB
                counter['TotalIndexedDB'] += counter['add']['Total']
                counter['TotalIndexedDB'] += counter['get']['Total']
                counter['TotalIndexedDB'] += counter['getAll']['Total']
                counter['TotalIndexedDB'] += counter['delete']['Total']

                # finalize the row in CSV file
                writeToCSVFile(temp_sitename, None, counter, 'begining')
                # write the result of each method
                OnScreen('none', (31 + len(temp_sitename) + 
                                  len(str(counter['setItem']['Total'])))
                         * ' ' + '\t (FD+FE+IF+FO+WH+DO+SW+TR+VR=Total) '
                         , 'Gg')

                for m in methods:
                    writeToCSVFile(temp_sitename, m, counter, 'middle')
                # finalize the row in CSV file
                writeToCSVFile(temp_sitename, None, counter, 'end')
                """
                initilize the dictionary "counter"; make all values zero
                to prepare it for the next round
                """
                for key, value in counter.items():
                    if isinstance(value, dict):
                        for k, v in value.items():
                            counter[key][k] = 0
                    else:
                        counter[key] = 0

                counter['TotalFiles'] = 1
                temp_sitename = websiteName

        except (KeyboardInterrupt, SystemExit):
            raise

        except Exception as inst:
            OnScreen('none', str(inst), 'RW')
            traceback.print_exc()
            continue
