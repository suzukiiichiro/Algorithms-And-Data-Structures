# 行末にバックスラッシュを書くと、その後ろの改行が無視され、行が継続していると
# 判断されます。
long_name_variable = 1
if (long_name_variable == 1111111111) \
or (long_name_variable == 2222222222) \
or (long_name_variable == 3333333333):
    print('long value')
else:
    print('not long value')
