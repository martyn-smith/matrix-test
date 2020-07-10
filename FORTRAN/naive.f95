program matrix_test

    real(kind=8), dimension(4096, 4096) :: x, y, z
    call random_number(x)
    call random_number(y)

    do i= 1, size(z, 1)
        do j= 1, size(z, 2)
            do k= 1, 4096
                z(i,j) = z(i, j) + x(i, k) + y(k, j)
            end do
        end do
    end do

    print *, z(1,1)
end program