module.exports = function (robot) {
    robot.hear(/diags hostname/i, function (msg) {
        var getHostName = require('child_process').exec;
        getHostName('hostname', function (err, stdout, stderr) {
            var locHostName = (stdout); var dcName = locHostName.slice(0,3); var hostUp = locHostName.toUpperCase(); var dcUp = dcName.toUpperCase();
            msg.send(robot.name + " in " + dcUp + " checking in. " + "Hostname: " + hostUp);});
        getHostName();});};
