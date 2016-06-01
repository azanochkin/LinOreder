function scales_names = getScalesNames(scales)
    fields = fieldnames(scales);
    scales_names = scales.(fields{1}).Properties.VariableNames(2:2:end);
    for i = 2:numel(fields)
        if ~isempty(setdiff(scales_names, scales.(fields{i}).Properties.VariableNames(2:2:end)))
            error('Ўкалы разные!')
        end
    end
end
