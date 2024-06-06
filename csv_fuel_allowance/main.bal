import ballerina/io;

type InputData record {
    readonly int employee_id;
    int odometer_reading;
    decimal gallons;
    decimal gas_price;
};

type OutputData record {
    readonly int employee_id;
    int gas_fill_up_count = 0;
    decimal total_fuel_cost = 0;
    decimal total_gallons = 0;
    int start_miles_accrued = 0;
    int total_miles_accrued = 0;
};

type InputDataTable table<InputData>;

function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {

    table<OutputData> key<int> output = table key(employee_id) [];

    io:ReadableCSVChannel channel = check io:openReadableCsvFile(inputFilePath);
    var inputDataTable = check channel
        .toTable(InputData, ["employee_id", "odometer_reading", "gallons", "gas_price"])
        .ensureType(InputDataTable);

    foreach InputData employee in inputDataTable {
        if output.hasKey(employee.employee_id) {
            OutputData data = output.get(employee.employee_id);    
            data.gas_fill_up_count += 1;
            data.total_fuel_cost += employee.gas_price * employee.gallons;
            data.total_gallons +=  employee.gallons;
            data.total_miles_accrued = employee.odometer_reading - data.start_miles_accrued;
        } else {
            output.add({ 
                employee_id: employee.employee_id,
                gas_fill_up_count: 1,
                start_miles_accrued: employee.odometer_reading,
                total_miles_accrued: 0,
                total_gallons: employee.gallons,
                total_fuel_cost: employee.gas_price * employee.gallons
            });
        }
    }

    var outputChannel = check io:openWritableCsvFile(outputFilePath);
    foreach OutputData outputData in from var o in output order by o.employee_id select o {
        string[] rec = [
            outputData.employee_id.toString(), 
            outputData.gas_fill_up_count.toString(), 
            outputData.total_fuel_cost.toString(),
            outputData.total_gallons.toString(),
            outputData.total_miles_accrued.toString()
            ];
        _ = check outputChannel.write(rec);
    }
    check outputChannel.close();
}