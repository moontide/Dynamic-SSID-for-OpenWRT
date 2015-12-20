function init_char_int_index()
{
	for (i=0; i<=255; i++)
	{
		t=sprintf ("%c", i);
		_char_int_index[t]=i;
	}
}

#
# 假设 UTF-8 字符串是被截断的，则删除被截断后的字符的剩余字节，以保证字符串的结尾不出现乱码
#
# 若要使用此函数，需要先在 BEGIN{} 中执行 init_char_int_index () 初始化函数来初始化 _char_int_index 数组
#
function fix_utf8_truncation(s)
{
	len=split(s,a,"");
	last_byte=_char_int_index[a[len]]; # 整个字符串的最后一个字节
	if (debug) print "	last_byte:", a[len], and(last_byte,0xc0) > "/dev/stderr";
	if (and(last_byte,0xC0)==0x80 || and(last_byte,0xC0)==0xC0) #检查 utf-8 多字节字符被截断的情况
	{
		# 先找到 utf-8 字节序列的起始字节
		for (i=len; i>=len-6; i--)
		{
			if(and(_char_int_index[a[i]],0xC0)==0xC0)
			{
				first_utf8_byte=_char_int_index[a[i]];	# 最后一个 utf-8 字符的首个字节
				if (debug) print "	在", i, "处发现 utf-8 起始字节", first_utf8_byte > "/dev/stderr"
				break;
			}
		}

		bytes=0;
		# 计算该 utf-8 字符应该有多少个字节组成(虽然通常汉字由 3 字节组成，但这样更灵活、通用，避免遇到 4 个字节的字符导致结果不符的情况)
		while (and(first_utf8_byte,0x80)==0x80) # utf-8 首字节高位有多少位 1，就应该有多少个字节
		{
			first_utf8_byte=lshift(first_utf8_byte,1);
			bytes++;
		}

		# 然后判断 utf-8 首字节到字符串结尾的长度是否等于 utf-8 字符的完整字节长度，如果不是，则删除被截断的 utf-8 字符字节
		if ((len-i+1) != bytes)
		{
			if (debug) print "	本 utf-8 字符长度为", bytes, "字节，被截断后只剩下了", (len-i+1), "字节，这些字节应该被删除" > "/dev/stderr"
			s=substr(s, 1, i-1);
			if (debug) print "修复结束后的字符串: [" s "]" > "/dev/stderr";
		}
	}
	return s;
}

