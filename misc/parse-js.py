import os
from datetime import datetime
import argparse

# initializing
main_folder = '/media/namnam/b1d032a2-c26d-4ea4-96b8-93078f9f0023/Thesis/Sites/'
output_file = '/media/namnam/b1d032a2-c26d-4ea4-96b8-93078f9f0023/Thesis/parsed.csv'


def pr_color(FLAG, color, text):
    """
    make the texts colorful; read more here:
    https://stackoverflow.com/questions/287871/print-in-terminal-with-colors
    """
    if FLAG:
        time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
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
        print(time + '\t' + color + text + END)


def folder_parsing(output_file, main_folder):
    """
    finds specific files
    read more: https://dzone.com/articles/listing-a-directory-with-python
    """
    time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    for folder in os.listdir(main_folder):
        # number of directories, all files, .js files and .html files
        lenght = [0, 0, 0, 0]
        temp = []

        # find the most recent downloaded folder
        updated_folder = sorted(os.listdir(main_folder + folder + "/data/"))[-1]

        for path, directories, files in os.walk(main_folder + folder + "/data/" + updated_folder):
            # count number of folders in each site directory
            for dir in directories:
                lenght[0] += 1

            for file in files:
                # count number of files in each site directory
                lenght[1] += 1
                """count number of .js of .html files in each
                site directory and add to the temproray array"""
                if file.endswith('.js'):
                    lenght[2] += 1
                    temp.append(path[len(main_folder):] + '/' + file)
                if file.endswith('.html'):
                    lenght[3] += 1
                    temp.append(path[len(main_folder):] + '/' + file)

        # write the result into the output file
        with open(output_file, 'a') as out:
            for i in range(0, len(temp)):
                out.write(folder + ',' + str(lenght[0]) + ',' + str(lenght[1]))
                out.write(',' + str(lenght[2]) + ',' + str(lenght[3]))
                out.write(',' + temp[i] + ',' + time + '\n')

        text = '- ' + folder + ' - No. Files: ' + str(lenght[1])
        text += ' (js: ' + str(lenght[2]) + ' | html: ' + str(lenght[3])
        text += ') - Folders: ' + str(lenght[0])
        pr_color(FLAG, 'Gg', text)


if __name__ == '__main__':
    """
    gives options to the user to if she wants to see the results on terminal.
    read more here: https://stackoverflow.com/a/15301183
    """
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-S", "--show", help="Show the log",
        nargs='?', const=1, type=int, default=1)

    args = parser.parse_args()

    # checks if the the user wants to see the output or not
    if args.show:
        FLAG = True
    else:
        FLAG = False

    # writes the header of the file
    with open(output_file, 'w') as output:
        output.write('URL,No. of folders,No. of files,No. of JS files')
        output.write(',No. of HTML files,Path of file,Date\n')
        pr_color(FLAG, 'GW', 'The output file is created.')

    # start parsing the main folder
    folder_parsing(output_file, main_folder)

    # writes the footer of the file
    with open(output_file, 'a') as output:
        output.close()
        pr_color(FLAG, 'GW', 'The output file is closed.')
