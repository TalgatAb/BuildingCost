using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BuildingCost.Startup))]
namespace BuildingCost
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
