def cat_map(dest, source, range_len):
    return {source + i: dest + i for i in range(0, range_len)}


# If a value is not mapped it returns the input

print(cat_map(50, 98, 2))
print(cat_map(0, 69, 1))
print(cat_map(1, 0, 69))
