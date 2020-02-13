%% M-file for making all 4th order magic squares

 

clear; 

CPU = cputime;

M4 = zeros(4,4);

Ref16 = 1:1:16;

 

No_Mag4 = 0;

No_Mag411 = 0;

M4(1,1) = 16;

for i1 = 1:15

    M4(2,2) = i1;

    for i2 = 1:14

        if i2 < M4(2,2)

            M4(3,3) = i2;

        else 

            M4(3,3) = i2 + 1;

        end

        M4(4,4) = 34 - M4(1,1) - M4(2,2) - M4(3,3);

        EqualToOther = (M4(1,1) - M4(4,4))*(M4(2,2) - M4(4,4))*(M4(3,3) - M4(4,4));

        if (M4(4,4) > 0) & (M4(4,4) < 16) & (EqualToOther ~= 0)

            for i3 = 1:12

                SortRef4 = sort([M4(1,1),M4(2,2),M4(3,3),M4(4,4)]);

                if i3 < SortRef4(1)

                    M4(2,3) = i3;

                elseif i3 < SortRef4(2) - 1

                    M4(2,3) = i3 + 1;

                elseif i3 < SortRef4(3) - 2

                    M4(2,3) = i3 + 2;

                else

                    M4(2,3) = i3 + 3;

                end

                M4(3,2) = 34 - M4(2,2) - M4(2,3) - M4(3,3);

                EqualToOther = (M4(1,1) - M4(3,2))*(M4(2,2) - M4(3,2))*(M4(3,3) - M4(3,2))*(M4(4,4) - M4(3,2))*(M4(2,3) - M4(3,2));

                if (M4(3,2) > 0) & (M4(3,2) < 16) & (EqualToOther ~= 0)

                    for i4 = 1:10

                        SortRef6 = sort([SortRef4,M4(2,3),M4(3,2)]);

                        if i4 < SortRef6(1)

                            M4(4,1) = i4;

                        elseif i4 < SortRef6(2) - 1

                            M4(4,1) = i4 + 1;

                        elseif i4 < SortRef6(3) - 2

                            M4(4,1) = i4 + 2;

                        elseif i4 < SortRef6(4) - 3

                            M4(4,1) = i4 + 3;

                        elseif i4 < SortRef6(5) - 4

                            M4(4,1) = i4 + 4;

                        else

                            M4(4,1) = i4 + 5;

                        end

                        M4(1,4) = 34 - M4(2,3) - M4(3,2) - M4(4,1);

                        EqualToOther = (M4(1,1) - M4(1,4))*(M4(2,2) - M4(1,4))*(M4(3,3) - M4(1,4))*(M4(4,4) - M4(1,4))*(M4(2,3) - M4(1,4))*(M4(3,2) - M4(1,4))*(M4(4,1) - M4(1,4));

                        if (M4(1,4) > 0) & (M4(1,4) < 16) & (EqualToOther ~= 0)

                            for i5 = 1:8

                                SortRef8 = sort([SortRef6,M4(1,4),M4(4,1)]);

                                if i5 < SortRef8(1)

                                    M4(1,3) = i5;

                                elseif i5 < SortRef8(2) - 1

                                    M4(1,3) = i5 + 1;

                                elseif i5 < SortRef8(3) - 2

                                    M4(1,3) = i5 + 2;

                                elseif i5 < SortRef8(4) - 3

                                    M4(1,3) = i5 + 3;

                                elseif i5 < SortRef8(5) - 4

                                    M4(1,3) = i5 + 4;

                                elseif i5 < SortRef8(6) - 5

                                    M4(1,3) = i5 + 5;

                                elseif i5 < SortRef8(7) - 6

                                    M4(1,3) = i5 + 6;

                                else

                                    M4(1,3) = i5 + 7;

                                end

                                M4(4,3) = 34 - M4(1,3) - M4(2,3) - M4(3,3);

                                EqualToOther = (M4(1,1) - M4(4,3))*(M4(2,2) - M4(4,3))*(M4(3,3) - M4(4,3))*(M4(4,4) - M4(4,3))*(M4(2,3) - M4(4,3))*(M4(3,2) - M4(4,3))*(M4(4,1) - M4(4,3))*(M4(1,4) - M4(4,3))*(M4(1,3) - M4(4,3));

                                if (M4(4,3) > 0) & (M4(4,3) < 16) & (EqualToOther ~= 0)

                                    M4(4,2) = 34 - M4(4,1) - M4(4,3) - M4(4,4);

                                    EqualToOther = (M4(1,1) - M4(4,2))*(M4(2,2) - M4(4,2))*(M4(3,3) - M4(4,2))*(M4(4,4) - M4(4,2))*(M4(2,3) - M4(4,2))*(M4(3,2) - M4(4,2))*(M4(4,1) - M4(4,2))*(M4(1,4) - M4(4,2))*(M4(1,3) - M4(4,2))*(M4(4,3) - M4(4,2));

                                    if (M4(4,2) > 0) & (M4(4,2) < 16) & (EqualToOther ~= 0)

                                        M4(1,2) = 34 - M4(2,2) - M4(3,2) - M4(4,2);

                                        EqualToOther = (M4(1,1) - M4(1,2))*(M4(2,2) - M4(1,2))*(M4(3,3) - M4(1,2))*(M4(4,4) - M4(1,2))*(M4(2,3) - M4(1,2))*(M4(3,2) - M4(1,2))*(M4(4,1) - M4(1,2))*(M4(1,4) - M4(1,2))*(M4(1,3) - M4(1,2))*(M4(4,3) - M4(1,2))*(M4(4,2) - M4(1,2));

                                        Row1 = sum(M4(1,:));

                                        if (M4(1,2) > 0) & (M4(1,2) < 16) & (EqualToOther ~= 0) & (Row1 == 34)

                                            for i6 = 1:4

                                                SortRef12 = sort([SortRef8,M4(1,2),M4(1,3),M4(4,2),M4(4,3)]);

                                                if i6 < SortRef12(1)

                                                    M4(2,1) = i6;

                                                elseif i6 < SortRef12(2) - 1

                                                    M4(2,1) = i6 + 1;

                                                elseif i6 < SortRef12(3) - 2

                                                    M4(2,1) = i6 + 2;

                                                elseif i6 < SortRef12(4) - 3

                                                    M4(2,1) = i6 + 3;

                                                elseif i6 < SortRef12(5) - 4

                                                    M4(2,1) = i6 + 4;

                                                elseif i6 < SortRef12(6) - 5

                                                    M4(2,1) = i6 + 5;

                                                elseif i6 < SortRef12(7) - 6

                                                    M4(2,1) = i6 + 6;

                                                elseif i6 < SortRef12(8) - 7

                                                    M4(2,1) = i6 + 7;

                                                elseif i6 < SortRef12(9) - 8

                                                    M4(2,1) = i6 + 8;

                                                elseif i6 < SortRef12(10) - 9

                                                    M4(2,1) = i6 + 9;

                                                elseif i6 < SortRef12(11) - 10

                                                    M4(2,1) = i6 + 10;

                                                else

                                                    M4(2,1) = i6 + 11;

                                                end

                                                if M4(2,1) > M4(1,2)

                                                    M4(2,4) = 34 - M4(2,1) - M4(2,2) - M4(2,3);

                                                    M4(3,4) = 34 - M4(1,4) - M4(2,4) - M4(4,4);

                                                    M4(3,1) = 34 - M4(3,2) - M4(3,3) - M4(3,4);

                                                    Col1 = sum(M4(:,1));

                                                    SortM4 = sort([M4(1,:),M4(2,:),M4(3,:),M4(4,:)]);

                                                    if (SortM4 == Ref16) & (Col1 == 34) 

                                                        No_Mag4 = No_Mag4 + 1;

                                                        No_Mag411 = No_Mag411 + 1;

                                                        MagS4(:,:,No_Mag4) = M4;

                                                    end

                                                end

                                            end

                                        end

                                    end

                                end

                            end

                        end

                    end

                end

            end

        end

    end

end

 

No_Mag422 = 0;

M4(2,2) = 16;

for i1 = 1:15

    M4(1,1) = i1;

    for i2 = 1:14

        if i2 < M4(1,1)

            M4(3,3) = i2;

        else 

            M4(3,3) = i2 + 1;

        end

        M4(4,4) = 34 - M4(1,1) - M4(2,2) - M4(3,3);

        EqualToOther = (M4(1,1) - M4(4,4))*(M4(2,2) - M4(4,4))*(M4(3,3) - M4(4,4));

        if (M4(4,4) > 0) & (M4(4,4) < 16) & (EqualToOther ~= 0)

            for i3 = 1:12

                SortRef4 = sort([M4(1,1),M4(2,2),M4(3,3),M4(4,4)]);

                if i3 < SortRef4(1)

                    M4(2,3) = i3;

                elseif i3 < SortRef4(2) - 1

                    M4(2,3) = i3 + 1;

                elseif i3 < SortRef4(3) - 2

                    M4(2,3) = i3 + 2;

                else

                    M4(2,3) = i3 + 3;

                end

                M4(3,2) = 34 - M4(2,2) - M4(2,3) - M4(3,3);

                EqualToOther = (M4(1,1) - M4(3,2))*(M4(2,2) - M4(3,2))*(M4(3,3) - M4(3,2))*(M4(4,4) - M4(3,2))*(M4(2,3) - M4(3,2));

                if (M4(3,2) > 0) & (M4(3,2) < 16) & (EqualToOther ~= 0)

                    for i4 = 1:10

                        SortRef6 = sort([SortRef4,M4(2,3),M4(3,2)]);

                        if i4 < SortRef6(1)

                            M4(4,1) = i4;

                        elseif i4 < SortRef6(2) - 1

                            M4(4,1) = i4 + 1;

                        elseif i4 < SortRef6(3) - 2

                            M4(4,1) = i4 + 2;

                        elseif i4 < SortRef6(4) - 3

                            M4(4,1) = i4 + 3;

                        elseif i4 < SortRef6(5) - 4

                            M4(4,1) = i4 + 4;

                        else

                            M4(4,1) = i4 + 5;

                        end

                        M4(1,4) = 34 - M4(2,3) - M4(3,2) - M4(4,1);

                        EqualToOther = (M4(1,1) - M4(1,4))*(M4(2,2) - M4(1,4))*(M4(3,3) - M4(1,4))*(M4(4,4) - M4(1,4))*(M4(2,3) - M4(1,4))*(M4(3,2) - M4(1,4))*(M4(4,1) - M4(1,4));

                        if (M4(1,4) > 0) & (M4(1,4) < 16) & (EqualToOther ~= 0)

                            for i5 = 1:8

                                SortRef8 = sort([SortRef6,M4(1,4),M4(4,1)]);

                                if i5 < SortRef8(1)

                                    M4(1,3) = i5;

                                elseif i5 < SortRef8(2) - 1

                                    M4(1,3) = i5 + 1;

                                elseif i5 < SortRef8(3) - 2

                                    M4(1,3) = i5 + 2;

                                elseif i5 < SortRef8(4) - 3

                                    M4(1,3) = i5 + 3;

                                elseif i5 < SortRef8(5) - 4

                                    M4(1,3) = i5 + 4;

                                elseif i5 < SortRef8(6) - 5

                                    M4(1,3) = i5 + 5;

                                elseif i5 < SortRef8(7) - 6

                                    M4(1,3) = i5 + 6;

                                else

                                    M4(1,3) = i5 + 7;

                                end

                                M4(4,3) = 34 - M4(1,3) - M4(2,3) - M4(3,3);

                                EqualToOther = (M4(1,1) - M4(4,3))*(M4(2,2) - M4(4,3))*(M4(3,3) - M4(4,3))*(M4(4,4) - M4(4,3))*(M4(2,3) - M4(4,3))*(M4(3,2) - M4(4,3))*(M4(4,1) - M4(4,3))*(M4(1,4) - M4(4,3))*(M4(1,3) - M4(4,3));

                                if (M4(4,3) > 0) & (M4(4,3) < 16) & (EqualToOther ~= 0)

                                    M4(4,2) = 34 - M4(4,1) - M4(4,3) - M4(4,4);

                                    EqualToOther = (M4(1,1) - M4(4,2))*(M4(2,2) - M4(4,2))*(M4(3,3) - M4(4,2))*(M4(4,4) - M4(4,2))*(M4(2,3) - M4(4,2))*(M4(3,2) - M4(4,2))*(M4(4,1) - M4(4,2))*(M4(1,4) - M4(4,2))*(M4(1,3) - M4(4,2))*(M4(4,3) - M4(4,2));

                                    if (M4(4,2) > 0) & (M4(4,2) < 16) & (EqualToOther ~= 0)

                                        M4(1,2) = 34 - M4(2,2) - M4(3,2) - M4(4,2);

                                        EqualToOther = (M4(1,1) - M4(1,2))*(M4(2,2) - M4(1,2))*(M4(3,3) - M4(1,2))*(M4(4,4) - M4(1,2))*(M4(2,3) - M4(1,2))*(M4(3,2) - M4(1,2))*(M4(4,1) - M4(1,2))*(M4(1,4) - M4(1,2))*(M4(1,3) - M4(1,2))*(M4(4,3) - M4(1,2))*(M4(4,2) - M4(1,2));

                                        Row1 = sum(M4(1,:));

                                        if (M4(1,2) > 0) & (M4(1,2) < 16) & (EqualToOther ~= 0) & (Row1 == 34)

                                            for i6 = 1:4

                                                SortRef12 = sort([SortRef8,M4(1,2),M4(1,3),M4(4,2),M4(4,3)]);

                                                if i6 < SortRef12(1)

                                                    M4(2,1) = i6;

                                                elseif i6 < SortRef12(2) - 1

                                                    M4(2,1) = i6 + 1;

                                                elseif i6 < SortRef12(3) - 2

                                                    M4(2,1) = i6 + 2;

                                                elseif i6 < SortRef12(4) - 3

                                                    M4(2,1) = i6 + 3;

                                                elseif i6 < SortRef12(5) - 4

                                                    M4(2,1) = i6 + 4;

                                                elseif i6 < SortRef12(6) - 5

                                                    M4(2,1) = i6 + 5;

                                                elseif i6 < SortRef12(7) - 6

                                                    M4(2,1) = i6 + 6;

                                                elseif i6 < SortRef12(8) - 7

                                                    M4(2,1) = i6 + 7;

                                                elseif i6 < SortRef12(9) - 8

                                                    M4(2,1) = i6 + 8;

                                                elseif i6 < SortRef12(10) - 9

                                                    M4(2,1) = i6 + 9;

                                                elseif i6 < SortRef12(11) - 10

                                                    M4(2,1) = i6 + 10;

                                                else

                                                    M4(2,1) = i6 + 11;

                                                end

                                                if M4(2,1) > M4(1,2)

                                                    M4(2,4) = 34 - M4(2,1) - M4(2,2) - M4(2,3);

                                                    M4(3,4) = 34 - M4(1,4) - M4(2,4) - M4(4,4);

                                                    M4(3,1) = 34 - M4(3,2) - M4(3,3) - M4(3,4);

                                                    Col1 = sum(M4(:,1));

                                                    SortM4 = sort([M4(1,:),M4(2,:),M4(3,:),M4(4,:)]);

                                                    if (SortM4 == Ref16) & (Col1 == 34) 

                                                        No_Mag4 = No_Mag4 + 1;

                                                        No_Mag422 = No_Mag422 + 1;

                                                        MagS4(:,:,No_Mag4) = M4;

                                                    end

                                                end

                                            end

                                        end

                                    end

                                end

                            end

                        end

                    end

                end

            end

        end

    end

end

 

No_Mag412 = 0;

M4(1,2) = 16;

for i1 = 1:15

    M4(2,2) = i1;

    for i2 = 1:14

        if i2 < M4(2,2)

            M4(3,2) = i2;

        else 

            M4(3,2) = i2 + 1;

        end

        M4(4,2) = 34 - M4(1,2) - M4(2,2) - M4(3,2);

        EqualToOther = (M4(1,2) - M4(4,2))*(M4(2,2) - M4(4,2))*(M4(3,2) - M4(4,2));

        if (M4(4,2) > 0) & (M4(4,2) < 16) & (EqualToOther ~= 0)

            for i3 = 1:12

                SortRef4 = sort([M4(1,2),M4(2,2),M4(3,2),M4(4,2)]);

                if i3 < SortRef4(1)

                    M4(2,3) = i3;

                elseif i3 < SortRef4(2) - 1

                    M4(2,3) = i3 + 1;

                elseif i3 < SortRef4(3) - 2

                    M4(2,3) = i3 + 2;

                else

                    M4(2,3) = i3 + 3;

                end

                M4(3,3) = 34 - M4(2,2) - M4(2,3) - M4(3,2);

                EqualToOther = (M4(1,2) - M4(3,3))*(M4(2,2) - M4(3,3))*(M4(3,2) - M4(3,3))*(M4(4,2) - M4(3,3))*(M4(2,3) - M4(3,3));

                if (M4(3,3) > 0) & (M4(3,3) < 16) & (EqualToOther ~= 0)

                    for i4 = 1:10

                        SortRef6 = sort([SortRef4,M4(2,3),M4(3,3)]);

                        if i4 < SortRef6(1)

                            M4(1,3) = i4;

                        elseif i4 < SortRef6(2) - 1

                            M4(1,3) = i4 + 1;

                        elseif i4 < SortRef6(3) - 2

                            M4(1,3) = i4 + 2;

                        elseif i4 < SortRef6(4) - 3

                            M4(1,3) = i4 + 3;

                        elseif i4 < SortRef6(5) - 4

                            M4(1,3) = i4 + 4;

                        else

                            M4(1,3) = i4 + 5;

                        end

                        M4(4,3) = 34 - M4(1,3) - M4(2,3) - M4(3,3);

                        EqualToOther = (M4(1,2) - M4(4,3))*(M4(2,2) - M4(4,3))*(M4(3,2) - M4(4,3))*(M4(4,2) - M4(4,3))*(M4(2,3) - M4(3,3))*(M4(3,3) - M4(4,3))*(M4(1,3) - M4(4,3));

                        if (M4(4,3) > 0) & (M4(4,3) < 16) & (EqualToOther ~= 0)

                            for i5 = 1:8

                                SortRef8 = sort([SortRef6,M4(1,3),M4(4,3)]);

                                if i5 < SortRef8(1)

                                    M4(1,1) = i5;

                                elseif i5 < SortRef8(2) - 1

                                    M4(1,1) = i5 + 1;

                                elseif i5 < SortRef8(3) - 2

                                    M4(1,1) = i5 + 2;

                                elseif i5 < SortRef8(4) - 3

                                    M4(1,1) = i5 + 3;

                                elseif i5 < SortRef8(5) - 4

                                    M4(1,1) = i5 + 4;

                                elseif i5 < SortRef8(6) - 5

                                    M4(1,1) = i5 + 5;

                                elseif i5 < SortRef8(7) - 6

                                    M4(1,1) = i5 + 6;

                                else

                                    M4(1,1) = i5 + 7;

                                end

                                M4(4,4) = 34 - M4(1,1) - M4(2,2) - M4(3,3);

                                EqualToOther = (M4(1,2) - M4(4,4))*(M4(2,2) - M4(4,4))*(M4(3,2) - M4(4,4))*(M4(4,2) - M4(4,4))*(M4(2,3) - M4(4,4))*(M4(3,3) - M4(4,4))*(M4(1,3) - M4(4,4))*(M4(4,3) - M4(4,4))*(M4(1,1) - M4(4,4));

                                if (M4(4,4) > 0) & (M4(4,4) < 16) & (EqualToOther ~= 0)

                                    M4(1,4) = 34 - M4(1,1) - M4(1,2) - M4(1,3);

                                    EqualToOther = (M4(1,2) - M4(1,4))*(M4(2,2) - M4(1,4))*(M4(3,2) - M4(1,4))*(M4(4,2) - M4(1,4))*(M4(2,3) - M4(1,4))*(M4(3,3) - M4(1,4))*(M4(1,3) - M4(1,4))*(M4(4,3) - M4(1,4))*(M4(1,1) - M4(1,4))*(M4(4,4) - M4(1,4));

                                    if (M4(1,4) > 0) & (M4(1,4) < 16) & (EqualToOther ~= 0)

                                        M4(4,1) = 34 - M4(1,4) - M4(2,3) - M4(3,2);

                                        EqualToOther = (M4(1,2) - M4(4,1))*(M4(2,2) - M4(4,1))*(M4(3,2) - M4(4,1))*(M4(4,2) - M4(4,1))*(M4(2,3) - M4(4,1))*(M4(3,3) - M4(4,1))*(M4(1,3) - M4(4,1))*(M4(4,3) - M4(4,1))*(M4(1,1) - M4(4,1))*(M4(4,4) - M4(4,1))*(M4(1,4) - M4(4,1));

                                        Row4 = sum(M4(4,:));

                                        if (M4(4,1) > 0) & (M4(4,1) < 16) & (EqualToOther ~= 0) & (Row4 == 34)

                                            for i6 = 1:4

                                                SortRef12 = sort([SortRef8,M4(1,1),M4(4,4),M4(1,4),M4(4,1)]);

                                                if i6 < SortRef12(1)

                                                    M4(2,1) = i6;

                                                elseif i6 < SortRef12(2) - 1

                                                    M4(2,1) = i6 + 1;

                                                elseif i6 < SortRef12(3) - 2

                                                    M4(2,1) = i6 + 2;

                                                elseif i6 < SortRef12(4) - 3

                                                    M4(2,1) = i6 + 3;

                                                elseif i6 < SortRef12(5) - 4

                                                    M4(2,1) = i6 + 4;

                                                elseif i6 < SortRef12(6) - 5

                                                    M4(2,1) = i6 + 5;

                                                elseif i6 < SortRef12(7) - 6

                                                    M4(2,1) = i6 + 6;

                                                elseif i6 < SortRef12(8) - 7

                                                    M4(2,1) = i6 + 7;

                                                elseif i6 < SortRef12(9) - 8

                                                    M4(2,1) = i6 + 8;

                                                elseif i6 < SortRef12(10) - 9

                                                    M4(2,1) = i6 + 9;

                                                elseif i6 < SortRef12(11) - 10

                                                    M4(2,1) = i6 + 10;

                                                else

                                                    M4(2,1) = i6 + 11;

                                                end

                                                M4(2,4) = 34 - M4(2,1) - M4(2,2) - M4(2,3);

                                                M4(3,4) = 34 - M4(1,4) - M4(2,4) - M4(4,4);

                                                M4(3,1) = 34 - M4(3,2) - M4(3,3) - M4(3,4);

                                                Col1 = sum(M4(:,1));

                                                SortRef16 = sort([M4(1,:),M4(2,:),M4(3,:),M4(4,:)]);

                                                if (SortRef16 == Ref16) & (Col1 == 34) 

                                                    No_Mag4 = No_Mag4 + 1;

                                                    No_Mag412 = No_Mag412 + 1;

                                                    MagS4(:,:,No_Mag4) = M4;

                                                end

                                            end

                                        end

                                    end

                                end

                            end

                        end

                    end

                end

            end

        end

    end

end

 

No_Mag4normal = 0;

No_Mag4abnormal = 0;

for i = 1:880

    RefM4 = mod(MagS4(:,:,i)-ones(4,4),4) + 1;

    Refsum(1) = sum(RefM4(1,:));

    Refsum(2) = sum(RefM4(2,:));

    Refsum(3) = sum(RefM4(3,:));

    Refsum(4) = sum(RefM4(4,:));

    Refsum(5) = sum(RefM4(:,1));

    Refsum(6) = sum(RefM4(:,2));

    Refsum(7) = sum(RefM4(:,3));

    Refsum(8) = sum(RefM4(:,4));

    Refsum(9) = sum([RefM4(1,1),RefM4(2,2),RefM4(3,3),RefM4(4,4)]);

    Refsum(10) = sum([RefM4(1,4),RefM4(2,3),RefM4(3,2),RefM4(4,1)]);  

    if max(Refsum) == 10

        No_Mag4normal = No_Mag4normal +1;

        MagS4normal(:,:,No_Mag4normal) = MagS4(:,:,i);

    elseif max(Refsum) == 14

        No_Mag4abnormal = No_Mag4abnormal +1;

        MagS4abnormal(:,:,No_Mag4abnormal) = MagS4(:,:,i);

    end    

end

 

CPU = cputime - CPU;

%%%%%%%%%%%%%%%%%%%% CPU = > 2.8538 sec

%%%%%%%%%%%%%%%%%%%% There are 880 magic squares of order 4. 

%%%%%%%%%%%%%%%%%%%% There are 656 magic squares of order 4 constructed by orthogonal auxiliary squares. 