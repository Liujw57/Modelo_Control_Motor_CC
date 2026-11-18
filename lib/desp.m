function desp = desp(arr, p)
    arr = circshift(arr, p);
    arr(1:p) = 0;
    desp = arr;
end