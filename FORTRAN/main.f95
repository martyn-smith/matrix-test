program matrix_test

    real(kind=8), dimension(4096, 4096) :: x, y, z
    call random_number(x)
    call random_number(y)
    z = matmul(x,y)
    print *, z(1,1)
end program