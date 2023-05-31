
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using SourceNotes.Areas.Identity;
using SourceNotes.Data;
using SourceNotes.Services;
using Microsoft.AspNetCore.ResponseCompression;
using SourceNotes.Hubs.SourceNotes.Hubs;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();
builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true).AddRoles<IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>();
builder.Services.AddRazorPages();

builder.Services.AddServerSideBlazor();
builder.Services.AddScoped<AuthenticationStateProvider, RevalidatingIdentityAuthenticationStateProvider<IdentityUser>>();
//builder.Services.AddSingleton<WeatherForecastService>();
builder.Services.AddScoped<AppState>();


builder.Services.AddDbContext<SourceNotes.Data.SourceNotesContext>(options =>
options.UseSqlServer(
    builder.Configuration.GetConnectionString("DefaultConnection")));
// Scoped creates an instance for each user
builder.Services.AddScoped<ProjectServices>();
builder.Services.AddScoped<MethodologyService>();
builder.Services.AddScoped<KeywordService>();
builder.Services.AddScoped<NoteServices>();
builder.Services.AddScoped<NotesService>();
builder.Services.AddScoped<PeopleService>();
builder.Services.AddScoped<NotesToKeywordService>();
builder.Services.AddScoped<NotesToPersonService>();
builder.Services.AddScoped<GlobalServices>();
builder.Services.AddScoped<UsersToProjectsService>();
builder.Services.AddScoped<CommentServices>();
builder.Services.AddScoped<LabBookServices>();
//USED FOR SIGNAL R
builder.Services.AddResponseCompression(opts =>
{
    opts.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(
        new[] { "application/octet-stream" });
});

var app = builder.Build();

//Add API Key from secrets
/*var ApiKey = builder.Configuration["TinyAPI"];
app.MapGet("/", () => ApiKey);*/


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseResponseCompression();

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.MapBlazorHub();
app.MapHub<ChatHub>("/chathub");
app.MapFallbackToPage("/_Host");

app.Run();
