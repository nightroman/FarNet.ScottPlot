using ScottPlot;
using System;
using System.Diagnostics;
using System.Threading;
using System.Windows.Forms;

namespace FarNet.ScottPlot;

/// <summary>
/// This type inherits <see cref="Plot"/>, adds new form related properties and the method <see cref="Show"/>.
/// </summary>
public class FormPlot : Plot
{
    readonly CancellationTokenSource _tokenSource = new();
    FormsPlotViewer _form;

    /// <summary>
    /// Gets or sets the form title.
    /// </summary>
    public string FormTitle { get; set; }

    /// <summary>
    /// Gets the cancellation token for live plot tasks.
    /// </summary>
    public CancellationToken CancellationToken { get; }

    /// <summary>
    /// Gets true if the form is cancelling.
    /// </summary>
    public bool IsCancellationRequested => CancellationToken.IsCancellationRequested;

    /// <summary>
    /// Creates a new plot for showing in a form.
    /// </summary>
    /// <param name="formTitle">Specifies the form window title.</param>
    public FormPlot(string formTitle = null)
    {
        CancellationToken = _tokenSource.Token;
        FormTitle = formTitle;
    }

    /// <summary>
    /// Shows this plot in a form or renders the shown form after plot changes.
    /// </summary>
    public void Show()
    {
        if (_form is null)
        {
            var thread = new Thread(Start)
            {
                Name = "Plot thread.",
                IsBackground = true
            };
            thread.SetApartmentState(ApartmentState.STA);
            thread.Start();
        }
        else
        {
            if (CancellationToken.IsCancellationRequested)
                return;

            try
            {
                _form.formsPlot1.Render();
            }
            catch (InvalidOperationException ex)
            {
                // E.g. "Object is currently in use elsewhere."
                Trace.WriteLine($"ScottPlot error: {ex.Message}");
            }
        }
    }

    void Start()
    {
        _form = new FormsPlotViewer(this, (int)Width, (int)Height, FormTitle ?? "Plot");

        _form.Load += (s, e) =>
        {
            _form.Activate();
        };

        _form.formsPlot1.KeyDown += (s, e) =>
        {
            if (e.KeyCode == Keys.Escape)
            {
                _tokenSource.Cancel();
                _form.Close();
            }
        };

        try
        {
            _form.ShowDialog();
        }
        finally
        {
            _tokenSource.Cancel();
            _form.Dispose();
        }
    }
}
