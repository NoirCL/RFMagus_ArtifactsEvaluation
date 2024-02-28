function drawCodeBook(phi1_d, phi2_d, phi3_d, phi4_d)
    global flag_ris_num

    if flag_ris_num == 1
        visualize_matrix(phi1_d);
        sgtitle("Configuration: MTS_1")
    elseif flag_ris_num == 2
        visualize_matrix(phi1_d);
        sgtitle("Configuration: MTS_1")
        visualize_matrix(phi2_d);
        sgtitle("Configuration: MTS_2")
    elseif flag_ris_num == 3
        visualize_matrix(phi1_d);
        sgtitle("Configuration: MTS_1")
        visualize_matrix(phi2_d);
        sgtitle("Configuration: MTS_2")
        visualize_matrix(phi3_d);
        sgtitle("Configuration: MTS_3")
    elseif flag_ris_num == 4
        visualize_matrix(phi1_d);
        sgtitle("Configuration: MTS_1")
        visualize_matrix(phi2_d);
        sgtitle("Configuration: MTS_2")
        visualize_matrix(phi3_d);
        sgtitle("Configuration: MTS_3")
        visualize_matrix(phi4_d);
        sgtitle("Configuration: MTS_4")
    end
end