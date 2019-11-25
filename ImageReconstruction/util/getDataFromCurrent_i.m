function [c_data_i, tx_i] = getDataFromCurrent_i(i,j,app)
      current_i = app.oversight.current_i; k = app.IndexSpinner.Value;
      ijk = [i(current_i), j(current_i), k];
      [~,c_data_i,tx_i] = findDataFromIdx(app.c_data, ijk);
end