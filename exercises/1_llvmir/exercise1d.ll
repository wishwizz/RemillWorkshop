define i32 @ps3_random_number() {
    ret i32 42
}

define i32 @add_42(i32 %n) {
    %1 = add i32 %n, 42
    ret i32 %1
}

define i32 @bytes_to_bits(i32 %n) {
    %1 = mul i32 8, %n
    ret i32 %1
}

define i32 @upper_32_bits(i64 %n) {
    %1 = lshr i64 %n, 32
    %2 = trunc i64 %1 to i32
    ret i32 %2
}

define i32 @vm_operation(i1 %do_add, i32 %x, i32 %y) {
entry:
    %retval = alloca i32, align 4
    %do_add.addr = alloca i1, align 1
    store i1 %do_add, ptr %do_add.addr, align 1
    %0 = load i1, ptr %do_add.addr, align 1
    %and = and i1 %0, 1
    %cmp = icmp eq i1 %and, 1
    br i1 %cmp, label %if.then, label %if.else

if.then:
    %add = add i32 %x, %y
    store i32 %add, ptr %retval, align 4
    br label %return

if.else:
    %subtr = sub i32 %x, %y
    store i32 %subtr, ptr %retval, align 4
    br label %return

return:
    %ret = load i32, ptr %retval, align 4
    ret i32 %ret
}

declare i32 @store_value(i32 %val, i32 %key)

define void @pass_to_store_value(i32 %n) {
entry:
    %retval = alloca i32, align 4
    %n.addr = alloca i32, align 4
    store i32 %n, ptr %n.addr, align 4
    %0 = load i32, ptr %n.addr, align 4
    %and = and i32 %0, 1
    %cmp = icmp eq i32 %and, 0
    br i1 %cmp, label %if.then, label %if.else

if.then:
    %val_uneven = load i32, ptr %n.addr, align 4
    %call1 = call i32 @store_value(i32 %val_uneven, i32 noundef 99)
    br label %return


if.else:
    %val_even = load i32, ptr %n.addr, align 4
    %call2 = call i32 @store_value(i32 %val_even , i32 noundef 512)
    br label %return

return:
    ret void
}
