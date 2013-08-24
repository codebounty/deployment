options = {
    getContractors: undefined,
    token: process.env.GITHUB_TOKEN,
    templates: undefined,
    templateData: undefined,
    secrets: {

    }
};

app = require('clabot').createApp(options);
app.listen(process.env.PORT || 1337);
