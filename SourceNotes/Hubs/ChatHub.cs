namespace SourceNotes.Hubs
{
    using global::SourceNotes.Data;
    using global::SourceNotes.Services;
    using Microsoft.AspNetCore.SignalR;

    namespace SourceNotes.Hubs
    {
        public class ChatHub : Hub
        {
            private readonly ProjectServices _projectservices;
            private readonly MethodologyService _methodologyservice;
            private readonly KeywordService _keywordservice;
            public ChatHub(MethodologyService methodologyservice, ProjectServices projectservices, KeywordService keywordservice)
            {
                _methodologyservice= methodologyservice;
                _projectservices= projectservices;
                _keywordservice = keywordservice;
            }

            public async Task getMethodology()
            {
                //methodologyservice.getMethodology(1)
                await Clients.All.SendAsync("ReceiveMethodology", _methodologyservice.getMethodology(1));
            }
            public void updateMethodology(String text)
            {

              _methodologyservice.setMethodology(text,1);
            }
        }
    }
}
