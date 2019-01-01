from copy import copy
import traceback
from pyjsparser import PyJsParser
import os
import re
from datetime import datetime

main_folder = '/media/'
sites_folder = main_folder + 'Sites/'
js_files = main_folder + 'parsed.csv'
site_list = main_folder + 'dowloaded_sites.csv'
output_file = main_folder + 'result.csv'

# blacklist of sites (not-fully-downloaded)
b_sites = []
# list of previously parsed sites
p_sites = []
# the blacklist of .js files (common .js libraries); needs to be in lowercase
b_files = ['jquery', 'jqx', 'lazyload', 'angular', 'ember', 'addthis', 'unified', 'prototype', 'aculo', 'qooxdoo', 'react', 'smartclient', 'sprout', 'wakanda', 'zkoss', 'webix', 'jqwidget', 'dojo', 'dhtmlx', 'enyo', 'ext', 'google', 'mootool', 'openui', 'rocket', 'font', 'analytics', 'onesignalsdk', 'recaptcha']

# list of the queries the program needs to look for during parsing
queries = ['setItem', 'getItem', 'removeItem', 'clear', 'indexedStore', 'createObjectStore', 'createIndex', 'indexedDB', 'openDatabase', 'transaction', 'executeSql']
counter = {
    'setItem': {'FunctionDeclaration': 0,
                'IfStatement': 0,
                'ForStatement': 0,
                'WhileStatement': 0,
                'DoWhileStatement': 0,
                'SwitchStatement': 0,
                'TryStatement': 0,
                'Total': 0
                },
    'getItem': {'FunctionDeclaration': 0,
                'IfStatement': 0,
                'ForStatement': 0,
                'WhileStatement': 0,
                'DoWhileStatement': 0,
                'SwitchStatement': 0,
                'TryStatement': 0,
                'Total': 0
                },
    'removeItem': {'FunctionDeclaration': 0,
                   'IfStatement': 0,
                   'ForStatement': 0,
                   'WhileStatement': 0,
                   'DoWhileStatement': 0,
                   'SwitchStatement': 0,
                   'TryStatement': 0,
                   'Total': 0
                   },
    'clear': {'FunctionDeclaration': 0,
              'IfStatement': 0,
              'ForStatement': 0,
              'WhileStatement': 0,
              'DoWhileStatement': 0,
              'SwitchStatement': 0,
              'TryStatement': 0,
              'Total': 0
              },
    'indexedStore': {'FunctionDeclaration': 0,
                     'IfStatement': 0,
                     'ForStatement': 0,
                     'WhileStatement': 0,
                     'DoWhileStatement': 0,
                     'SwitchStatement': 0,
                     'TryStatement': 0,
                     'Total': 0
                     },
    'createObjectStore': {'FunctionDeclaration': 0,
                          'IfStatement': 0,
                          'ForStatement': 0,
                          'WhileStatement': 0,
                          'DoWhileStatement': 0,
                          'SwitchStatement': 0,
                          'TryStatement': 0,
                          'Total': 0
                          },
    'createIndex': {'FunctionDeclaration': 0,
                    'IfStatement': 0,
                    'ForStatement': 0,
                    'WhileStatement': 0,
                    'DoWhileStatement': 0,
                    'SwitchStatement': 0,
                    'TryStatement': 0,
                    'Total': 0
                    },
    'indexedDB': {'FunctionDeclaration': 0,
                  'IfStatement': 0,
                  'ForStatement': 0,
                  'WhileStatement': 0,
                  'DoWhileStatement': 0,
                  'SwitchStatement': 0,
                  'TryStatement': 0,
                  'Total': 0
                  },
    'openDatabase': {'FunctionDeclaration': 0,
                     'IfStatement': 0,
                     'ForStatement': 0,
                     'WhileStatement': 0,
                     'DoWhileStatement': 0,
                     'SwitchStatement': 0,
                     'TryStatement': 0,
                     'Total': 0
                     },
    'transaction': {'FunctionDeclaration': 0,
                    'IfStatement': 0,
                    'ForStatement': 0,
                    'WhileStatement': 0,
                    'DoWhileStatement': 0,
                    'SwitchStatement': 0,
                    'TryStatement': 0,
                    'Total': 0
                    },
    'executeSql': {'FunctionDeclaration': 0,
                   'IfStatement': 0,
                   'ForStatement': 0,
                   'WhileStatement': 0,
                   'DoWhileStatement': 0,
                   'SwitchStatement': 0,
                   'TryStatement': 0,
                   'Total': 0
                   },
    'TotalIndexedDB': 0,
    'TotalWebSQL': 0,
    'TotalLocalStorage': 0,
    'TotalFiles': 0
    }

i = 0
z = 0
temp_sitename = ''
result_k = []
path_k = []


# writes the info to csv file
def writeToCSVFile(site, query, data, FLAG):
    if os.stat(output_file).st_size == 0:
        F = True
    else:
        F = False
    with open(output_file, "a+") as output:
        """
        if the file is empty then it writes the first line (header).
        The followings are the legends of the abbreviations:
        Fun: Function Declaration
        IfS: If Statement
        For: For Statement
        Whi: While Statement
        DoW: Do-While Statement
        Swt: Switch Statement
        Try: Try Statement
        Tot: Total
        """
        if F:
            output.write('DateTime,Site_Name,TotalFiles,')
            output.write('TotalLocalStorage,TotalWebSQL,TotalIndexedDB,')
            # localStorage (LST) - setItem (set)
            output.write('LST_set_Fun,LST_set_IfS,LST_set_For,LST_set_Whi,')
            output.write('LST_set_DoW,LST_set_Swt,LST_set_Try,LST_set_Tot,')
            # localStorage (LST) - getItem (get)
            output.write('LST_get_Fun,LST_get_IfS,LST_get_For,LST_get_Whi,')
            output.write('LST_get_DoW,LST_get_Swt,LST_get_Try,LST_get_Tot,')
            # localStorage (LST) - removeItem (rmv)
            output.write('LST_rmv_Fun,LST_rmv_IfS,LST_rmv_For,LST_rmv_Whi,')
            output.write('LST_rmv_DoW,LST_rmv_Swt,LST_rmv_Try,LST_rmv_Tot,')
            # localStorage (LST) - clear (clr)
            output.write('LST_clr_Fun,LST_clr_IfS,LST_clr_For,LST_clr_Whi,')
            output.write('LST_clr_DoW,LST_clr_Swt,LST_clr_Try,LST_clr_Tot,')
            # WebSQL (WSQ) - indexedStore (ist)
            output.write('WSQ_ist_Fun,WSQ_ist_IfS,WSQ_ist_For,WSQ_ist_Whi,')
            output.write('WSQ_ist_DoW,WSQ_ist_Swt,WSQ_ist_Try,WSQ_ist_Tot,')
            # WebSQL (WSQ) - createObjectStore (cos)
            output.write('WSQ_cos_Fun,WSQ_cos_IfS,WSQ_cos_For,WSQ_cos_Whi,')
            output.write('WSQ_cos_DoW,WSQ_cos_Swt,WSQ_cos_Try,WSQ_cos_Tot,')
            # WebSQL (WSQ) - createIndex (cin)
            output.write('WSQ_cin_Fun,WSQ_cin_IfS,WSQ_cin_For,WSQ_cin_Whi,')
            output.write('WSQ_cin_DoW,WSQ_cin_Swt,WSQ_cin_Try,WSQ_cin_Tot,')
            # IndexedDB (IDB) - indexedDB (idb)
            output.write('IDB_idb_Fun,IDB_idb_IfS,IDB_idb_For,IDB_idb_Whi,')
            output.write('IDB_idb_DoW,IDB_idb_Swt,IDB_idb_Try,IDB_idb_Tot,')
            # IndexedDB (IDB) - openDatabase (odb)
            output.write('IDB_odb_Fun,IDB_odb_IfS,IDB_odb_For,IDB_odb_Whi,')
            output.write('IDB_odb_DoW,IDB_odb_Swt,IDB_odb_Try,IDB_odb_Tot,')
            # IndexedDB (IDB) - transaction (trs)
            output.write('IDB_trs_Fun,IDB_trs_IfS,IDB_trs_For,IDB_trs_Whi,')
            output.write('IDB_trs_DoW,IDB_trs_Swt,IDB_trs_Try,IDB_trs_Tot,')
            # IndexedDB (IDB) - executeSql (exe)
            output.write('IDB_exe_Fun,IDB_exe_IfS,IDB_exe_For,IDB_exe_Whi,')
            output.write('IDB_exe_DoW,IDB_exe_Swt,IDB_exe_Try,IDB_exe_Tot,\n')

        # if it is the beginning of the row
        if FLAG == 'begining':
            output.write(datetime.now().strftime("%Y-%m-%d %H:%M:%S") + ',')
            output.write(site + ',')
            output.write(str(counter['TotalFiles']) + ',')
            output.write(str(counter['TotalLocalStorage']) + ',')
            output.write(str(counter['TotalWebSQL']) + ',')
            output.write(str(counter['TotalIndexedDB']) + ',')
            # print the result on the screen
            on_screen('none', ' *  ' + site + ' - Total Files        ' + ' -  ' + str(counter['TotalFiles']), 'PB')
            on_screen('none', ' *  ' + site + ' - Total LocalStorage ' + ' -  ' + str(counter['TotalLocalStorage']), 'PB')
            on_screen('none', ' *  ' + site + ' - Total IndexedDB    ' + ' -  ' + str(counter['TotalIndexedDB']), 'PB')
            on_screen('none', ' *  ' + site + ' - Total WebSQL       ' + ' -  ' + str(counter['TotalWebSQL']), 'PB')
            """
        write the data of the row for each query in this order:
        'setItem', 'getItem', 'removeItem', 'clear',
        'indexedStore', 'createObjectStore', 'createIndex',
        'indexedDB', 'openDatabase', 'transaction', 'executeSql'
        first 4 items are for localStorage
        next 3 items are for WebSQL
        and last 4 items are for IndexedDB
        """
        elif FLAG == 'middle':
            output.write(str(counter[query]['FunctionDeclaration']) + ',')
            output.write(str(counter[query]['IfStatement']) + ',')
            output.write(str(counter[query]['ForStatement']) + ',')
            output.write(str(counter[query]['WhileStatement']) + ',')
            output.write(str(counter[query]['DoWhileStatement']) + ',')
            output.write(str(counter[query]['SwitchStatement']) + ',')
            output.write(str(counter[query]['TryStatement']) + ',')
            output.write(str(counter[query]['Total']) + ',')
            # print the result on the screen for each query
            s = 19 - len(query)
            on_screen('none', ' ~  ' + site + ' - ' + query + s * ' ' + ' -  ' + str(counter[query]['Total']), 'Gg')
        # finalize the row
        elif FLAG == 'end':
            output.write('\n')
            output.close()


# prints on screen
def on_screen(FLAG, text, color):
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

    if FLAG == 'border':
        print(u'\u2551'.encode('utf-8') + sp1 * ' ' + color + text + END + sp21 * ' ' + u'\u2551'.encode('utf-8'))
    elif FLAG == 'b-center':
        print(u'\u255A'.encode('utf-8') + sp1 * u'\u2550'.encode('utf-8') + color + text + END + sp21 * u'\u2550'.encode('utf-8') + u'\u255D'.encode('utf-8'))
    elif FLAG == 'b-right':
        print(u'\u255A'.encode('utf-8') + (sp-2) * u'\u2550'.encode('utf-8') + color + text + END + u'\u255D'.encode('utf-8'))
    elif FLAG == 'center':
        print(sp0 * ' ' + color + text + END + sp20 * ' ')
    elif FLAG == 'right':
        print(sp * ' ' + color + text + END)
    else:
        print(color + text + END)


# recursively search for the query in the parsed JSON
def find_values(json, query):
    global z
    x = 0
    try:
        """
        if the json is not a dictionary (dic) then it will be a list (array)
        then apparently each item of it is a dictionarry and it will
        recursively check each of them
        """
        if isinstance(json, list) and json:
            for d in json:
                find_values(d, query)
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
                if value is not dic and is not empty then it is a list and
                reaching the value is not possible by e.g. dic["key"];
                dic = {"key1":[{"key2":"value2"}]}
                dic["key1"]["key2"] is not working but dic["key1"][0]["key2"]
                works.
                this part of the code works on the lists in dictionary
                """
                elif isinstance(value, list) and value:
                    for v in value:
                        # add the position of (key, value) pair in the list
                        path_k.append(x)
                        find_values(v, query)
                        x += 1
                        path_k.pop()
                    x = 0
                # if value is dictionary
                elif isinstance(value, dict):
                    find_values(value, query)
                # if value is value and equals the query
                if value == query:
                    result_k.append(z)
                    result_k.append(copy(path_k))
                path_k.pop()

    except Exception as err:
        print('\x1b[1;37;41m{}\x1b[0m'.format(str(err)))
        traceback.print_exc()


# find the type of the path of each query
def find_type(array, json, query):
    try:
        # walk through the list (array) of paths
        for i in range(0, len(array)):
            item = ''
            ptype = []
            # find the tyep of path (ptype)
            if i % 2 == 0:
                item = json['body'][array[i]]
                try:
                    ptype.append(item["type"])
                except:
                    ptype.append(' ')
                key = array[i+1]
                # find the type of each path
                for j in range(0, len(key)):
                    if isinstance(key[j], int):
                        pass
                    elif isinstance(item[key[j]], dict):
                        item = item[key[j]]
                        try:
                            ptype.append(item["type"])
                        except:
                            ptype.append(' ')
                    elif isinstance(item[key[j]], list):
                        # record the location of the target in the list
                        loc = key[j+1]
                        item = item[key[j]][loc]
                        try:
                            ptype.append(item["type"])
                        except:
                            ptype.append(' ')
                    else:
                        item = item[key[j]]
                # count the number of occurrence of items
                counter[query]['FunctionDeclaration'] += ptype.count('FunctionDeclaration')
                counter[query]['IfStatement'] += ptype.count('IfStatement')
                counter[query]['ForStatement'] += ptype.count('ForStatement')
                counter[query]['WhileStatement'] += ptype.count('WhileStatement')
                counter[query]['DoWhileStatement'] += ptype.count('DoWhileStatement')
                counter[query]['SwitchStatement'] += ptype.count('SwitchStatement')
                counter[query]['TryStatement'] += ptype.count('TryStatement')

    except Exception as err:
        print('\x1b[1;37;41m{}\x1b[0m'.format(str(err)))
        traceback.print_exc()


# find the time difference
def time_delta(time0):
    time1 = datetime.now()
    delta = round((time1 - time0).total_seconds(), 2)
    on_screen('b-right', ' {}s '.format(delta), 'gW')


# read list of .js/.html files
with open(js_files, 'r') as js:
    all_js_list = sorted(js.read().splitlines())
    js_list = []
    for js in all_js_list:
        html = js.split(',')[4]
        if html.isdigit() and int(html) >= 1:
            js_list.append(js)

# create a blackkist of not-fully-downloaded ones
with open(site_list, 'r') as js:
    sites = sorted(js.read().splitlines())
    for site in sites:
        if site.split(',')[1] != 'website_is_downloaded':
            b_sites.append(site.split(',')[0])

# create a blackkist of sites which are already parsed (to avoid duplication)
with open(output_file, 'r') as js:
    sites = sorted(js.read().splitlines())
    for site in sites:
        if site.split(',')[1] != 'Site_Name':
            p_sites.append(site.split(',')[1])
    # remove duplications; read more: https://stackoverflow.com/a/7961390/4741225
    p_sites = list(set(p_sites))
    p_sites = sorted(p_sites)

# start loading each .js/.html file to get parsed
temp_sitename = js_list[0].split(',')[0]
for js_f in js_list:
    try:
        time0 = datetime.now()
        i += 1
        js_f = js_f.split(',')
        f = js_f[5].split('/')[-1].lower()
        s = js_f[0]
        websiteName = str(js_f[0])
        fileName = str(f)

        # check if site is already parsed
        if websiteName in p_sites:
            """
            find the length of the longest string in the list
            and justify the websiteName to the longest one
            read more: https://stackoverflow.com/a/873333/4741225
            """
            length = len(max(p_sites, key=len))
            websiteName = websiteName + (length - len(websiteName)) * ' '
            on_screen('none', '({}/{}) Already parsed: {}'.format(i, len(js_list), websiteName), 'gW')
            temp_sitename = js_list[i].split(',')[0]
            continue

        if websiteName == temp_sitename:
            counter['TotalFiles'] += 1

            # print the processing function on the screen
            row, col = os.popen('stty size', 'r').read().split()
            print(u'\u2554'.encode('utf-8') + (int(col)-2) * u'\u2550'.encode('utf-8') + u'\u2557'.encode('utf-8'))
            file_size = round(os.stat((sites_folder + js_f[5])).st_size / 1024.0, 1)
            on_screen('border', js_f[5] + ' (' + str(file_size) + ' kB)', 'none')
            on_screen('border', '=== {}/{} ==++== {} ==='.format(i, len(js_list), datetime.now().strftime("%Y-%m-%d %H:%M:%S")), 'BO')

            # check if the file or site is blacklisted
            if s in b_sites:
                on_screen('b-right', 'blacklisted site', 'WR')
                continue
            elif any(w in f for w in b_files):
                on_screen('b-right', 'blacklisted file', 'WR')
                continue

            # prepare the .js/.html for getting parsed
            with open(sites_folder + js_f[5], 'r') as f:
                js_file = f.read().decode('utf-8')
            if js_f[5].endswith('.html'):
                js_file = re.findall('(?si)<script>(.*?)</script>', js_file)
                js_file = ''.join(js_file)

            """
            start parsing
            read more: https://github.com/PiotrDabkowski/pyjsparser
            """
            p = PyJsParser()
            parsed = p.parse(js_file)

            # parse the JSON file for each query
            for q in queries:
                find_values(parsed['body'], q)
                find_type(result_k, parsed, q)
                # initilize the items
                result_k = []
                path_k = []
                z = 0

            # print the tiem in seconds spent on each file
            time_delta(time0)

        if websiteName != temp_sitename or i == len(js_list):
            if i == len(js_list):
                counter['TotalFiles'] += 1
            # count the total number of each query regardless its type
            for q in queries:
                for key, value in counter[q].items():
                    if key != 'Total':
                        counter[q]['Total'] += value
            # count the total number of queries in LocalStorage
            counter['TotalLocalStorage'] += counter['setItem']['Total']
            counter['TotalLocalStorage'] += counter['getItem']['Total']
            counter['TotalLocalStorage'] += counter['removeItem']['Total']
            counter['TotalLocalStorage'] += counter['clear']['Total']
            # count the total number of queries in WebSQL
            counter['TotalWebSQL'] += counter['openDatabase']['Total']
            counter['TotalWebSQL'] += counter['transaction']['Total']
            counter['TotalWebSQL'] += counter['executeSql']['Total']
            # count the total number of queries in IndexedDB
            counter['TotalIndexedDB'] += counter['indexedStore']['Total']
            counter['TotalIndexedDB'] += counter['createObjectStore']['Total']
            counter['TotalIndexedDB'] += counter['createIndex']['Total']
            counter['TotalIndexedDB'] += counter['indexedDB']['Total']

            # finalize the row in CSV file
            writeToCSVFile(temp_sitename, None, counter, 'begining')
            # write the result of each query
            for q in queries:
                writeToCSVFile(temp_sitename, q, counter, 'middle')
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
        on_screen('none', str(inst), 'RW')
        traceback.print_exc()
continue
