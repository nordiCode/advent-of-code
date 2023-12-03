file = open("p1.txt","r")
grid = [list(x.strip()) for x in file]

max_rows = len(grid) 
max_cols = len(grid[0]) 
tree_count = 0
for x in range(0,max_rows):
    for y in range(0,max_cols):
        if x == 0 or x == max_rows - 1 or y == 0 or y == max_cols - 1 :
            tree_count += 1
            continue
        else:
            
            left = grid[x][:y]
            right = grid[x][y+1:]
            up = []
            down = []
            for z in range(0,max_cols):
                y = int(y)
                if z < x:
                    up.append(grid[z][y])
                elif z > x:
                    down.append(grid[z][y])
                elif z == x:
                    continue
            if all([int(grid[x][y]) > int(z) for z in left]) or all([int(grid[x][y]) > int(z) for z in right]) or all([int(grid[x][y]) > int(z) for z in up]) or all([int(grid[x][y]) > int(z) for z in down]):
                tree_count +=1
           
           
          
print(f"the tree count {tree_count}")
# 30373 all included
# 25512
# 65332
# 33549
# 35390