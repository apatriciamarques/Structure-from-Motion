function HglobalTruth = to_global(H1_to, idx_global)
    HglobalTruth = cell(1, 6);
    for i = 1:6
        % Logic: pass to 1 coordinates and then to idx_global coordinates
        % Equivalent: H1_to{idx_global} * inv(H1_to{i})
        HglobalTruth{i} = H1_to{idx_global} / H1_to{i};
    end
end