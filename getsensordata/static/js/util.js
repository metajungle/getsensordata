define(["uri.js/URI"], function (URI) {
    return {
        toTitleCase: function(str) {
            return str.replace(/\w\S*/g, 
                function(txt) {
                    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            });
        }, 
        namePretty: function(value) {
            return this.toTitleCase(value.replace(/_/g, ' '));
        }, 
        uriPretty: function(value) {
            var uri = URI(value);
            var protocol = uri.protocol();
            if (protocol == 'http') {
                if (uri.fragment() != '') {
                    return this.namePretty(uri.fragment());
                } else {
                    return this.namePretty(uri.filename());
                }
            } else if (protocol == 'urn') {
                var s = uri.segment(); 
                if (s && s.length > 0) {
                    return this.namePretty(s[s.length - 1]);
                }
            }
            return this.namePretty(value);
        }
    }
});
