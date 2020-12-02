# 此程序的目的是把 https://godbolt.org/ 中MIPS gcc 5.4
# 编译出来的汇编转换为QtSpim等能运行的汇编文件


def main():
    with open("./in.s", 'r') as inMISP:
        read_data = inMISP.read()
    read_data = read_data.replace(".ascii", ".asciiz")
    read_data = read_data.replace("$L", "L")
    read_data = read_data.replace("\\000", "")
    read_data = read_data.replace(" b  ", " jal")
    lines = read_data.splitlines()

    # .data部分
    outMISP = "# SPIM:\n"
    outMISP = outMISP + ".data\n"

    for line in lines:
        if line[0:2] == 'LC' or line.find('.asciiz') != -1:
            outMISP = outMISP + line + '\n'

    # .text部分
    outMISP = outMISP + ".text\n.globl main   # 防止出错\n"
    i_scan_int = -100
    i_scan_float = -100
    i_scan_double = -100
    i_print_string = -100
    i_print_int = -100
    i_print_float = -100
    i_print_double = -100
    if_main = False
    i = 0
    while i < len(lines):

        # IO部分
        if lines[i] == 'scan_int:':
            i_scan_int = i
        if i == i_scan_int + 5:
            i_scan_int = -100
            outMISP = outMISP + """
        # 读取int
        lw      $3,8($fp)
        li      $v0, 5
        syscall
        # 存入数据到$3的指针
        sw      $2,0($3)
        """ + '\n'

        if lines[i] == 'scan_float:':
            i_scan_float = i
        if i == i_scan_float + 5:
            i_scan_float = -100
            outMISP = outMISP + """
        # 读取float
        lw      $3,8($fp)
        li      $v0, 6
        syscall
        # 存入数据到$3的指针
        swc1    $f0,0($3)
        """ + '\n'

        if lines[i] == 'scan_double:':
            i_scan_double = i
        if i == i_scan_double + 5:
            i_scan_double = -100
            outMISP = outMISP + """
        # 读取double
        lw      $3,8($fp)
        li      $v0, 7
        syscall
        # 存入数据到$3的指针
        swc1    $f0,0($3)
        swc1    $f1,4($3)
        """ + '\n'

        if lines[i] == 'print_string:':
            i_print_string = i
        if i == i_print_string + 5:
            i_print_string = -100
            outMISP = outMISP + """
        # 打印string
        li      $v0, 4
        syscall
        """ + '\n'

        if lines[i] == 'print_int:':
            i_print_int = i
        if i == i_print_int + 5:
            i_print_int = -100
            outMISP = outMISP + """
        # 打印int
        li      $v0, 1
        syscall
        """ + '\n'

        if lines[i] == 'print_float:':
            i_print_float = i
        if i == i_print_float + 5:
            i_print_float = -100
            outMISP = outMISP + """
        # 打印float
        li      $v0, 2
        syscall
        """ + '\n'

        if lines[i] == 'print_double:':
            i_print_double = i
        if i == i_print_double + 6:
            i_print_double = -100
            outMISP = outMISP + """
        # 打印double
        li      $v0, 3
        syscall
        """ + '\n'


        # main部分
        if lines[i] == 'main:':
            if_main = True
        
        if if_main and lines[i].find('LC') != -1:
            
            c = lines[i][lines[i].find('LC')+2:lines[i].find(')')]
            outMISP = outMISP + """
        la      $4,LC""" + c + '\n'
            i += 2

        # 添加入输出
        if not (lines[i][0:2] == 'LC' or lines[i].find('.asciiz') != -1):
            outMISP = outMISP + lines[i] + '\n'

        i += 1

    # 程序截止部分
    # outMISP = outMISP + """
    #     # 程序截止
    #     li $v0, 10
    #     syscall
    # """

    print(outMISP)
    with open('./out.s','w',encoding='UTF-8') as f:
        f.write(outMISP)

if __name__ == "__main__":
    
    print("""# https://godbolt.org/ C语言编写范例：
# void scan_int(int *a){}
# void scan_float(float *a){}
# void scan_double(double *a){}
# void print_string(a){}
# void print_int(int a){}
# void print_float(float a){}
# void print_double(double a){}
# void main(){
# //your code
# }
""")
    main()