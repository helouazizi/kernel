void print_char(char c) {
    static volatile char *video = (volatile char *)0xB8000;
    static int pos = 0;
    video[pos++] = c;
    video[pos++] = 0x1F;  // white on blue attribute
}

void kernel_main() {
    print_char('H');
    print_char('i');
    print_char('!');
    while (1) {}
}
