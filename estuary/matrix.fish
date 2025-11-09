# ````
# **Usage Example:**
# ````fish
# # ...existing code...
# set m (matrix_create 3 3 0)
# set m (matrix_set $m 2 2 5)
# matrix_print $m
# # ...existing code...
# ````

# Create a matrix with given rows and columns, initialized to a value
function matrix_create
    set -l rows $argv[1]
    set -l cols $argv[2]
    set -l val $argv[3]
    set -l matrix
    for i in (seq $rows)
        set -l row
        for j in (seq $cols)
            set row $row $val
        end
        set matrix $matrix (string join ',' $row)
    end
    echo $matrix
end

# Get element at (row, col)
function matrix_get
    set -l matrix $argv[1]
    set -l row_idx $argv[2]
    set -l col_idx $argv[3]
    set -l row (string split ',' (echo $matrix | sed -n "$row_idx"p))
    echo $row[$col_idx]
end

# Set element at (row, col) to value
function matrix_set
    set -l matrix $argv[1]
    set -l row_idx $argv[2]
    set -l col_idx $argv[3]
    set -l value $argv[4]
    set -l rows (string split '\n' $matrix)
    set -l row (string split ',' $rows[$row_idx])
    set row[$col_idx] $value
    set rows[$row_idx] (string join ',' $row)
    echo (string join '\n' $rows)
end

# Print the matrix
function matrix_print
    set -l matrix $argv[1]
    for row in (string split '\n' $matrix)
        echo (string replace ',' ' ' $row)
    end
end
